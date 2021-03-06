
CREATE TABLE base.phone_type_localized (
  phone_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE phone_type_localized (
  FOREIGN KEY (phone_type) REFERENCES phone_type (phone_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (phone_type, translated)
) INHERITS( base.phone_type_localized );

CREATE TABLE log.phone_type_localized (
) INHERITS( base.logging, base.phone_type_localized );

CREATE INDEX log_phone_type_localized_phone_type_idx ON log.phone_type_localized( phone_type );
CREATE INDEX log_phone_type_localized_log_transaction_id_idx ON log.phone_type_localized( log_transaction_id );

