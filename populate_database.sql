
-- -----------------------------------------------------
-- Create Example Users
-- -----------------------------------------------------
-- User passwords are all just the username with "pass" appended:
--
-- User     Password
-- ------   --------
-- user1    user1pass
-- user2    user2pass
-- staff1   staff1pass
-- staff2   staff2pass
-- admin1   admin1pass
--
-- Hashes were generated using the included password_hash_generator.py script,
-- with the salt 'ExampleSaltValue'.
-- -----------------------------------------------------

USE TreeTalk;

-- Insert Example Users/Members
INSERT INTO users (username, first_name, last_name, email, password, birth_date, location, role) VALUES
    ('user1', 'John', 'Smith', 'user1@example.com', '490cbfbe67bd8c617be3c6df6c829b6ac646ba3ae64f68f0a3cc284908855554', '01-01-1990', 'New Zealand', 'member'),
    ('user2', 'Helen', 'Green', 'user2@example.com', '2ffa2992addbd26a22490cc0a9b4bf7fa5ba2f218fccd3a57aaf299b7aa93dd9', '02-01-1989', 'New Zealand', 'member'),
    ('user3', 'Sue', 'Brown', 'user3@example.com', 'b69fda794abc570c3996aae5d8ac116db669cdf2dd55b205c6ae9c1a4bfb6d2a', '03-01-1988', 'New Zealand', 'member'),
    ('user4', 'Sarah', 'Jones', 'user4@example.com', '6ecfb27f2bb7236b72f6244eb15cc96fae1c5296a32e6f5867b705cf773c077b', '04-01-1987', 'New Zealand', 'member'),
    ('user5', 'Mary', 'Taylor', 'user5@example.com', '08650262ea4792f8607adf818216d72b42028456231efaa3c627607d0a68e0c5', '05-01-1986', 'New Zealand', 'member'),
    ('user6', 'Alice', 'Johnson', 'user6@example.com', '490cbfbe67bd8c617be3c6df6c829b6ac646ba3ae64f68f0a3cc284908855554', '-02-01-1991', 'New Zealand', 'member'),
    ('user7', 'Bob', 'Williams', 'user7@example.com', '2ffa2992addbd26a22490cc0a9b4bf7fa5ba2f218fccd3a57aaf299b7aa93dd9', '-03-01-1992', 'New Zealand', 'member'),
    ('user8', 'Charlie', 'Brown', 'user8@example.com', 'b69fda794abc570c3996aae5d8ac116db669cdf2dd55b205c6ae9c1a4bfb6d2a', '-04-01-1993', 'New Zealand', 'member'),
    ('user9', 'Dave', 'Davis', 'user9@example.com', '6ecfb27f2bb7236b72f6244eb15cc96fae1c5296a32e6f5867b705cf773c077b', '05-01-1994', 'New Zealand', 'member'),
    ('user10', 'Eve', 'White', 'user10@example.com', '08650262ea4792f8607adf818216d72b42028456231efaa3c627607d0a68e0c5', '06-01-1995', 'New Zealand', 'member'),
    ('user11', 'Frank', 'Black', 'user11@example.com', '490cbfbe67bd8c617be3c6df6c829b6ac646ba3ae64f68f0a3cc284908855554', '07-01-1996', 'New Zealand', 'member'),
    ('user12', 'Grace', 'Green', 'user12@example.com', '2ffa2992addbd26a22490cc0a9b4bf7fa5ba2f218fccd3a57aaf299b7aa93dd9', '08-01-1997', 'New Zealand', 'member'),
    ('user13', 'Hank', 'Blue', 'user13@example.com', 'b69fda794abc570c3996aae5d8ac116db669cdf2dd55b205c6ae9c1a4bfb6d2a', '09-01-1985', 'New Zealand', 'member'),
    ('user14', 'Ivy', 'Red', 'user14@example.com', '6ecfb27f2bb7236b72f6244eb15cc96fae1c5296a32e6f5867b705cf773c077b', '10-01-1978', 'New Zealand', 'member'),
    ('user15', 'Jack', 'Yellow', 'user15@example.com', '08650262ea4792f8607adf818216d72b42028456231efaa3c627607d0a68e0c5', '11-01-1978', 'New Zealand', 'member'),
    ('user16', 'Karen', 'Pink', 'user16@example.com', '490cbfbe67bd8c617be3c6df6c829b6ac646ba3ae64f68f0a3cc284908855554', '12-01-1978', 'New Zealand', 'member'),
    ('user17', 'Leo', 'Gray', 'user17@example.com', '2ffa2992addbd26a22490cc0a9b4bf7fa5ba2f218fccd3a57aaf299b7aa93dd9', '01-01-1978', 'New Zealand', 'member'),
    ('user18', 'Mia', 'Purple', 'user18@example.com', 'b69fda794abc570c3996aae5d8ac116db669cdf2dd55b205c6ae9c1a4bfb6d2a', '02-01-1978', 'New Zealand', 'member'),
    ('user19', 'Nate', 'Orange', 'user19@example.com', '6ecfb27f2bb7236b72f6244eb15cc96fae1c5296a32e6f5867b705cf773c077b', '03-01-1978', 'New Zealand', 'member'),
    ('user20', 'Olive', 'Silver', 'user20@example.com', '08650262ea4792f8607adf818216d72b42028456231efaa3c627607d0a68e0c5', '04-01-1978', 'New Zealand', 'member'),
    ('user21', 'Paul', 'Gold', 'user21@example.com', '6ecfb27f2bb7236b72f6244eb15cc96fae1c5296a32e6f5867b705cf773c077b', '05-01-1978', 'New Zealand', 'member'),
    ('user22', 'Quinn', 'Bronze', 'user22@example.com', '08650262ea4792f8607adf818216d72b42028456231efaa3c627607d0a68e0c5', '06-01-1978', 'New Zealand', 'member');

-- Moderators
    ('moderator1', 'Tony', 'Stark', 'moderator1@example.com', 'b5ce5123ce0ccf4542807db003fec1c15bdfe4673d36ee1d78cc87cd6907cf51', '06-01-1985', 'New Zealand', 'moderator'),
    ('moderator2', 'Mark', 'Ruffalo', 'moderator2@example.com', '3e5bfcdba74fa42f55d5c855ade31bc46ff2106d02faa62700e30f7fac6b7e62', '07-01-1984', 'New Zealand', 'moderator'),
    ('moderator3', 'Bruce', 'Banner', 'moderator3@example.com', 'b5ce5123ce0ccf4542807db003fec1c15bdfe4673d36ee1d78cc87cd6907cf51', '08-01-1986', 'New Zealand', 'moderator'),
    ('moderator4', 'Natasha', 'Romanoff', 'moderator4@example.com', '3e5bfcdba74fa42f55d5c855ade31bc46ff2106d02faa62700e30f7fac6b7e62', '09-01-1987', 'New Zealand', 'moderator'),
    ('moderator5', 'Clint', 'Barton', 'moderator5@example.com', 'b5ce5123ce0ccf4542807db003fec1c15bdfe4673d36ee1d78cc87cd6907cf51', '10-01-1988', 'New Zealand', 'moderator'),
    ('moderator6', 'Steve', 'Rogers', 'moderator6@example.com', '3e5bfcdba74fa42f55d5c855ade31bc46ff2106d02faa62700e30f7fac6b7e62', '11-01-1989', 'New Zealand', 'moderator'),
    ('moderator7', 'Thor', 'Odinson', 'moderator7@example.com', 'b5ce5123ce0ccf4542807db003fec1c15bdfe4673d36ee1d78cc87cd6907cf51', '12-01-1990', 'New Zealand', 'moderator'),
    ('moderator8', 'Wanda', 'Maximoff', 'moderator8@example.com', '3e5bfcdba74fa42f55d5c855ade31bc46ff2106d02faa62700e30f7fac6b7e62', '01-01-1991', 'New Zealand', 'moderator'),
    ('moderator9', 'Vision', 'Vision', 'moderator9@example.com', 'b5ce5123ce0ccf4542807db003fec1c15bdfe4673d36ee1d78cc87cd6907cf51', '02-01-1992', 'New Zealand', 'moderator'),
    ('moderator10', 'Sam', 'Wilson', 'moderator10@example.com', '3e5bfcdba74fa42f55d5c855ade31bc46ff2106d02faa62700e30f7fac6b7e62', '03-01-1993', 'New Zealand', 'moderator');

-- Admins
    ('admin1', 'Jane', 'Doe', 'admin1@example.com', 'f96ccfe70a319f69019876d2be895235e7ee5d2b5f21dd51c6aa189b275acddf', '08-01-1983', 'New Zealand', 'admin'),
    ('admin2', 'John', 'Doe', 'admin2@example.com', 'f96ccfe70a319f69019876d2be895235e7ee5d2b5f21dd51c6aa189b275acddf', '09-01-1984', 'New Zealand', 'admin'),
    ('admin3', 'Alice', 'Wonder', 'admin3@example.com', 'f96ccfe70a319f69019876d2be895235e7ee5d2b5f21dd51c6aa189b275acddf', '10-01-1985', 'New Zealand', 'admin'),
    ('admin4', 'Bob', 'Builder', 'admin4@example.com', 'f96ccfe70a319f69019876d2be895235e7ee5d2b5f21dd51c6aa189b275acddf', '11-01-1986', 'New Zealand', 'admin');


-- Insert Messages
INSERT INTO messages (user_id, title, content) VALUES
(1, 'Welcome!', 'Welcome to our message board! Feel free to post any questions or messages.'),
(2, 'Moderation Guidelines', 'Please adhere to the community rules when posting.'),
(3, 'Tree Care Tips', 'Here are some great tips for taking care of your trees.'),
(4, 'Landscaping Ideas', 'Discuss and share your landscaping ideas here.'),
(5, 'Pest Control', 'Effective ways to manage pests in your garden.'),
(6, 'Organic Gardening', 'Share your experiences with organic gardening.'),
(7, 'Seasonal Planting Guide', 'What to plant this season? Let's discuss.'),
(8, 'Watering Schedules', 'Best practices for watering your plants.'),
(9, 'Soil Management', 'How to maintain fertile soil.'),
(10, 'Pruning Techniques', 'Best techniques for pruning.'),
(11, 'Fruit Tree Care', 'Care tips for your fruit trees.'),
(12, 'Vegetable Gardening', 'Growing vegetables in your backyard.'),
(13, 'Herbal Gardens', 'Creating and managing an herbal garden.'),
(14, 'Composting Basics', 'How to start composting.'),
(15, 'Lawn Maintenance', 'Keeping your lawn green and healthy.'),
(16, 'Sustainable Practices', 'Discuss sustainable gardening practices.'),
(17, 'Indoor Plants', 'Care tips for indoor plants.'),
(18, 'Garden Tools Review', 'Review of the latest gardening tools.'),
(19, 'Community Events', 'Upcoming gardening and landscaping events.'),
(20, 'Wildlife in Gardens', 'How to attract and manage wildlife in your gardens.');

-- Insert Replies
INSERT INTO replies (message_id, user_id, content) VALUES
(1, 2, 'Thanks for the warm welcome!'),
(2, 1, 'Understood, thanks for the guidelines.'),
(3, 3, 'Great tips, thanks!'),
(4, 4, 'Really helpful, thank you!'),
(5, 2, ''ve been looking for this info.'),
(6, 3, 'Absolutely agree with this point.'),
(7, 1, 'Interesting approach, thanks for sharing.'),
(8, 2, 'Helpful, was just planning my garden.'),
(9, 3, 'That's a useful tip!'),
(10, 1, 'Thanks, this was very needed.');
