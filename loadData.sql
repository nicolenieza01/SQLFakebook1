

INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
FROM PROJECT1.PUBLIC_USER_INFORMATION;

INSERT INTO Friends (user1_id, user2_id)
SELECT user1_id, user2_id
FROM PROJECT1.PUBLIC_ARE_FRIENDS;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT current_city, current_state, current_country
FROM PROJECT1.PUBLIC_USER_INFORMATION;

INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT U.user_id, C.city_id
FROM PROJECT1.PUBLIC_USER_INFORMATION U
LEFT JOIN Cities C ON U.current_city = C.city_name AND U.current_state = C.state_name AND U.current_country = C.country_name;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT U.user_id, C.city_id
FROM PROJECT1.PUBLIC_USER_INFORMATION U 
LEFT JOIN Cities C ON U.hometown_city = C.city_name AND U.hometown_state = C.state_name AND U.hometown_country = C.country_name;


INSERT INTO Programs (institution, concentration, degree)
SELECT DISTINCT institution_name, program_concentration, program_degree
FROM PROJECT1.PUBLIC_USER_INFORMATION
WHERE institution_name IS NOT NULL;


INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT U.user_id, P.program_id, U.program_year
FROM PROJECT1.PUBLIC_USER_INFORMATION U
LEFT JOIN Programs P ON U.institution_name = P.institution AND U.program_concentration = P.concentration AND U.program_degree = P.degree
WHERE institution_name IS NOT NULL;

INSERT INTO User_Events (event_id, event_creator_id, event_name, event_tagline, event_description, event_host, event_type, event_subtype, event_address, event_city_id, event_start_time, event_end_time)
SELECT E.event_id, E.event_creator_id, E.event_name, E.event_tagline, E.event_description, E.event_host, E.event_type, E.event_subtype, E.event_address, C.city_id, E.event_start_time, E.event_end_time
FROM PROJECT1.PUBLIC_EVENT_INFORMATION E 
LEFT JOIN Cities C ON E.event_city = C.city_name AND E.event_state = C.state_name AND E.event_country = C.country_name;

SET AUTOCOMMIT OFF;

INSERT INTO Albums (album_id, album_owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id)
SELECT DISTINCT album_id, owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id
FROM PROJECT1.PUBLIC_PHOTO_INFORMATION;

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link
FROM PROJECT1.PUBLIC_PHOTO_INFORMATION;

COMMIT;

SET AUTOCOMMIT ON;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM PROJECT1.PUBLIC_TAG_INFORMATION;
