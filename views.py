import os
import re
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_login import login_required, current_user
from werkzeug.utils import secure_filename
import mysql.connector
from flask_hashing import Hashing
from mysql.connector import connect, Error
from datetime import datetime
from app import app
import app.connect as connect

app.secret_key = 'ffbdec42bf94eaefd93ed692f13af3f6'
hashing = Hashing(app)

connection = None

def getCursor():
    global connection
    try:
        if connection is None or not connection.is_connected():
            connection = mysql.connector.connect(
                user=connect.dbuser,
                password=connect.dbpass,
                host=connect.dbhost,
                database=connect.dbname,
                autocommit=True
            )
            print("Connection successful")
        return connection.cursor(buffered=True), connection
    except mysql.connector.Error as e:
        print("Error while connecting to MySQL", e)
        return None, None

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in {'png', 'jpg', 'jpeg', 'gif'}

@app.route("/")
def home():
    return render_template("community.html")


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        password_hash = request.form['password_hash']
        email = request.form['email']
        birth_date = request.form['birth_date']
        location = request.form['location']
        file = request.files['profile_image']
        profile_image = None

        cursor, conn = getCursor()
        
        #  DD-MM-YYYY format
        try:
            birth_date_obj = datetime.strptime(birth_date, '%Y-%m-%d')
            birth_date = birth_date_obj.strftime('%Y-%m-%d')
        except ValueError:
            flash('Invalid date format. Use YYYY-MM-DD', 'error')
            return redirect(url_for('register'))


        if not re.match(r'^[A-Za-z\s,]+$', location):
            flash('Location must contain only letters, spaces, and commas.', 'error')
            return redirect(url_for('register'))

        if 'profile_image' not in request.files or file.filename == '':
            profile_image = 'default.png'
        elif file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            profile_image = filename
        else:
            flash('File not allowed', 'error')
            return redirect(url_for('register'))
        
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        account = cursor.fetchone()
        
        if account:
            flash('Username already exists!', 'error')
            return redirect(url_for('register'))
        
        password_hash = hashing.hash_value(password_hash, '1234abcd')

        cursor.execute("""
            INSERT INTO users (username, first_name, last_name, email, password_hash, birth_date, location, profile_image)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (username, first_name, last_name, email, password_hash, birth_date, location, profile_image))
        conn.commit()

        flash('Registration successful. Please login now.', 'success')
        return redirect(url_for('login'))
    
    return render_template("register.html")


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password_hash = request.form['password_hash']
        
        cursor, conn = getCursor()
        
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()

        if user and hashing.check_value(user[5], password_hash, '1234abcd'):
            session['user_id'] = user[0]
            session['username'] = username
            session['role'] = user[9]
            conn.commit()
            flash('Login successful!', 'success')
            
            return redirect(url_for('profile'))
        else:
            flash('Invalid username or password', 'error')

    return render_template('login.html')

# @app.route('/community', methods=['GET', 'POST'])
# @login_required
# def community():
#     # Fetch posts from the database
#     posts = Post.query.all()
#     return render_template('community.html', posts=posts)

@app.route('/submit_post', methods=['POST'])
@login_required
def submit_post():
    content = request.form['content']
    # image = request.files['image']
    # Save post to the database
    # Save the image if provided
    flash('Post submitted successfully!', 'success')
    return redirect(url_for('community'))

@app.route('/edit_post/<int:post_id>', methods=['GET', 'POST'])
@login_required
def edit_post(post_id):
    # Handle post editing
    flash('Post edited successfully!', 'success')
    return redirect(url_for('community'))

@app.route('/delete_post/<int:post_id>', methods=['POST'])
@login_required
def delete_post(post_id):
    # Handle post deletion
    flash('Post deleted successfully!', 'success')
    return redirect(url_for('community'))

@app.route('/submit_comment/<int:post_id>', methods=['POST'])
@login_required
def submit_comment(post_id):
    comment_content = request.form['comment']
    # Save comment to the database
    flash('Comment added!', 'success')
    return redirect(url_for('community'))

@app.route('/delete_comment/<int:comment_id>', methods=['POST'])
@login_required
def delete_comment(comment_id):
    # Handle comment deletion
    flash('Comment deleted!', 'success')
    return redirect(url_for('community'))

# def login():
#     # Implement the login functionality
#     if request.method == 'POST':
#         # Perform login check
#         flash('Please log in to access the Community Center.', 'danger')
#     return render_template('login.html')


# http://localhost:5000/logout - this will be the logout page
@app.route('/logout')
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   flash('You have been logged out.', 'success')
   return redirect(url_for('home'))


# @app.route('/logout')
# def logout():
#     session.clear()  
#     flash('You have been logged out.', 'success')
#     return redirect(url_for('home'))

@app.route('/profile', methods=['GET'])
def profile():
    if 'user_id' in session:
        cursor, conn = getCursor()
        cursor.execute("SELECT * FROM users WHERE user_id = %s", (session['user_id'],))
        user = cursor.fetchone()
        cursor.execute("SELECT * FROM messages WHERE user_id = %s ORDER BY created_at DESC", (session['user_id'],))
        messages = cursor.fetchall()
        account_to_delete = cursor.fetchone()
        return render_template("profile.html", user=user, account_to_delete=account_to_delete)


@app.route('/edit_profile', methods=['GET', 'POST'])
def edit_profile():
    if 'user_id' in session:
        cursor, conn = getCursor()
        if request.method == 'POST':
            email = request.form['email']
            birth_date = request.form['date_of_birth']
            location = request.form['location']
            file = request.files['profile_image']
            profile_image = None

            if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOADS_FOLDER'], filename))
                profile_image = filename

            cursor.execute("""
                UPDATE users SET email = %s, birth_date = %s, location = %s, profile_image = %s WHERE user_id = %s
            """, (email, birth_date, location, profile_image, session['user_id']))
            conn.commit()
            flash('Profile updated successfully!', 'success')
        
        cursor.execute("SELECT * FROM users WHERE user_id = %s", (session['user_id'],))
        user = cursor.fetchone()
        return render_template('edit_profile.html', user=user)
    return redirect(url_for('login'))

@app.route('/community')
def community():
    if 'username' not in session:
        return redirect(url_for('login'))

    cursor, conn = getCursor()
    cursor.execute("SELECT * FROM messages ORDER BY created_at DESC")
    messages = cursor.fetchall()

    return render_template('community.html', messages=messages)

@app.route('/post_message', methods=['POST'])
def post_message():
    user_id = session['user_id']
    text = request.form['message_id']

#     cursor, conn = getCursor()
#     cursor.execute("INSERT INTO messages (user_id, text) VALUES (%s, %s)", (user_id, text))
#     conn.commit()
#     return redirect(url_for('community'))
  
# memders(sidebar item)
@app.route('/members', methods=['GET', 'POST'])
def members():
    cursor, conn = getCursor()  # Ensure connection management is handled
    search_query = request.form.get('search', '').strip() if request.method == 'POST' else ''
    results = []
    message = ""

    if search_query:
        # Perform the search
        cursor.execute("""
            SELECT user_id, COALESCE(profile_image, '/static/assets/default.png') AS profile_image, first_name, last_name 
            FROM users 
            WHERE (role = 'member') AND (first_name LIKE %s OR last_name LIKE %s) 
            ORDER BY first_name, last_name
        """, ('%' + search_query + '%', '%' + search_query + '%'))
        results = cursor.fetchall()
        if not results:
            message = f"Sorry, there are no results for '{search_query}'."

    # Always fetch all members for the gallery, regardless of search
    cursor.execute("""
        SELECT user_id, COALESCE(profile_image, '/static/assets/default.png') AS profile_image, first_name, last_name
        FROM users
        WHERE role = 'member'
        ORDER BY first_name, last_name
    """)
    members = cursor.fetchall()
    return render_template("members.html", results=results, members=members, message=message)

    # admins(sidebar item)
@app.route('/admins', methods=['GET', 'POST'])
def admins():
    cursor, conn = getCursor()  # Ensure connection management is handled
    search_query = request.form.get('search', '').strip() if request.method == 'POST' else ''
    results = []
    message = ""

    if search_query:
        # Perform the search
        cursor.execute("""
            SELECT user_id, COALESCE(profile_image, '/static/assets/default.png') AS profile_image, first_name, last_name 
            FROM users 
            WHERE (role = 'admin') AND (first_name LIKE %s OR last_name LIKE %s) 
            ORDER BY first_name, last_name
        """, ('%' + search_query + '%', '%' + search_query + '%'))
        results = cursor.fetchall()
        if not results:
            message = f"Sorry, there are no results for '{search_query}'."

    # Always fetch all members for the gallery, regardless of search
    cursor.execute("""
        SELECT user_id, COALESCE(profile_image, '/static/assets/default.png') AS profile_image, first_name, last_name
        FROM users
        WHERE role = 'admin'
        ORDER BY first_name, last_name
    """)
    admins = cursor.fetchall()
    return render_template("admins.html", results=results, admins=admins, message=message)


   
  # moderators(sidebar item)
@app.route('/moderators' , methods=['GET', 'POST'])
def moderators():
    cursor, conn = getCursor()  # Ensure connection management is handled
    search_query = request.form.get('search', '').strip() if request.method == 'POST' else ''
    results = []
    message = ""

    if search_query:
        # Perform the search
        cursor.execute("""
            SELECT user_id, COALESCE(profile_image, '/static/assets/default.png') AS profile_image, first_name, last_name 
            FROM users 
            WHERE (role = 'moderator') AND (first_name LIKE %s OR last_name LIKE %s) 
            ORDER BY first_name, last_name
        """, ('%' + search_query + '%', '%' + search_query + '%'))
        results = cursor.fetchall()
        if not results:
            message = f"Sorry, there are no results for '{search_query}'."

    # Always fetch all members for the gallery, regardless of search
    cursor.execute("""
        SELECT user_id, COALESCE(profile_image, '/static/assets/default.jpg') AS profile_image, first_name, last_name
        FROM users
        WHERE role = 'moderator'
        ORDER BY first_name, last_name
    """)
    moderators = cursor.fetchall()
    return render_template("moderators.html", results=results, moderators=moderators, message=message)


if __name__ == '__main__':
    app.run(debug=True, port=5002)
