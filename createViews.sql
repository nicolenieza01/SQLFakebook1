CREATE VIEW VIEW_USER_INFORMATION 
AS SELECT 
US.USER_ID,
US.FIRST_NAME,
US.LAST_NAME,
US.YEAR_OF_BIRTH,
US.MONTH_OF_BIRTH,
US.DAY_OF_BIRTH,
US.GENDER,
CT.city_name AS CURRENT_CITY,
CT.state_name AS current_state,
CT.country_name AS current_country,
CY.city_name AS HOMETOWN_CITY,
CY.state_name as hometown_state,
CY.country_name AS hometown_country,
PR.INSTITUTION AS institution_name,
ED.PROGRAM_YEAR,
PR.CONCENTRATION AS program_concentration,
PR.DEGREE AS program_degree
FROM USERS US
LEFT JOIN User_Hometown_Cities USHC 
ON US.USER_ID = USHC.user_id

LEFT JOIN Cities CY 
ON USHC.hometown_city_id = CY.CITY_ID 

LEFT JOIN User_current_Cities USCC
ON US.USER_ID = USCC.USER_ID
 /*the hometown city to the correct user */
LEFT JOIN Cities CT 
ON USCC.current_city_id = CT.CITY_ID 
    /* match the current city to the correct user */
LEFT JOIN EDUCATION ED
ON US.USER_ID = ED.USER_ID
/* connection btwn education and user */
LEFT JOIN PROGRAMS PR 
ON ED.PROGRAM_ID = PR.PROGRAM_ID;

    /* match program id to education*/

    /* connection btwn education and user */

/* filter out */


CREATE VIEW VIEW_ARE_FRIENDS
AS SELECT 
USER1_ID, USER2_ID 
FROM FRIENDS;
/* all comes from same table so no joining or union necessary */

CREATE VIEW VIEW_PHOTO_INFORMATION
AS SELECT DISTINCT 
al.album_id,
al.album_owner_id,
al.cover_photo_id,
al.album_name,
al.album_created_time,
al.album_modified_time,
al.album_link,
al.album_visibility,
ph.photo_id,
ph.photo_caption,
ph.photo_created_time,
ph.photo_modified_time,
ph.photo_link
from Photos ph, Albums al
where ph.album_id = al.album_id;
/* ID's must match to ensure that same photo is being talked about */

CREATE VIEW VIEW_TAG_INFORMATION 
AS SELECT DISTINCT 
tag_photo_id,
tag_subject_id,
tag_created_time,
tag_x,
tag_y
FROM TAGS;
/* all comes from same table so no joining or union necessary */

CREATE VIEW VIEW_EVENT_INFORMATION 
AS SELECT
EV.event_id,
EV.event_creator_id,
EV.event_name,
EV.event_tagline,
EV.event_description,
EV.event_host,
EV.event_type,
EV.event_subtype,
EV.event_address,
C.city_name AS event_city,
C.state_name AS event_state,
C.country_name AS event_country,
EV.event_start_time,
EV.event_end_time
FROM Cities C, User_Events EV 
WHERE C.city_id = ev.event_city_id;

/*must ensure that ID's match up to ensure same event is being talked about */