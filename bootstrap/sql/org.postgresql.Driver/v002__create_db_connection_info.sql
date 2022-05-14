--
-- Table to be used for generic entities that are limited in number. Examples of generic entities are
-- Attribute entity, domain entities etc.
--
-- This reduces need for defining a table per entity.
--
CREATE TABLE IF NOT EXISTS generic_entity (
    id VARCHAR(36) GENERATED ALWAYS AS (json ->> 'id') STORED NOT NULL,
    -- Fully qualified name formed by entityType + "." + entityName
    fullyQualifiedName VARCHAR(256) GENERATED ALWAYS AS (json ->> 'fullyQualifiedName') STORED NOT NULL,
    json JSONB NOT NULL,
    updatedAt BIGINT GENERATED ALWAYS AS ((json ->> 'updatedAt')::bigint) STORED NOT NULL,
    updatedBy VARCHAR(256) GENERATED ALWAYS AS (json ->> 'updatedBy') STORED NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (fullyQualifiedName)
);

ALTER TABLE webhook_entity
DROP COLUMN deleted;
