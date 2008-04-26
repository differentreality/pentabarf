
CREATE OR REPLACE VIEW view_find_person AS
  SELECT
    view_person.person_id,
    view_person.name,
    view_person.first_name,
    view_person.last_name,
    view_person.nickname,
    view_person.public_name,
    coalesce( view_person.first_name, '' ) || ' ' || coalesce( view_person.last_name, '' ) || ' ' || coalesce( view_person.nickname, '' ) || ' ' || coalesce( view_person.public_name, '' ) || ' ' || coalesce( account.login_name, '' ) AS all_names,
    view_person.email,
    view_person.spam,
    view_person.gender,
    view_person.country,
    person_image.mime_type,
    mime_type.file_extension,
    conference.conference_id,
    conference_person.arrived,
    ARRAY(
      SELECT event_person.event_role
      FROM event_person INNER JOIN event USING( event_id )
      WHERE
        event_person.person_id = view_person.person_id AND
        event.conference_id = conference.conference_id
    ) AS event_role,
    ARRAY(
      SELECT account_role.role
      FROM auth.account INNER JOIN auth.account_role USING(account_id)
      WHERE
        account.person_id = view_person.person_id
    ) AS role
  FROM view_person
    CROSS JOIN conference
    LEFT OUTER JOIN conference_person USING (person_id,conference_id)
    LEFT OUTER JOIN auth.account USING (person_id)
    LEFT OUTER JOIN person_image USING (person_id)
    LEFT OUTER JOIN mime_type USING (mime_type)
  WHERE
    conference_person.person_id IS NOT NULL OR
    EXISTS(
      SELECT 1 FROM
        event_person
        INNER JOIN event USING(event_id)
      WHERE
        event.conference_id = conference.conference_id AND
        event_person.person_id = view_person.person_id
    )
  ORDER BY view_person.name, view_person.person_id
;

