
-- +migrate Up
ALTER TABLE organizations ALTER COLUMN logo DROP NOT NULL;
ALTER TABLE organizations ALTER COLUMN logo SET DEFAULT 0;
UPDATE organizations SET logo = NULL;
ALTER TABLE organizations RENAME logo TO logo_image_id;
ALTER TABLE organizations ALTER COLUMN logo_image_id SET DATA TYPE INTEGER USING logo_image_id::integer;
ALTER TABLE organizations ADD FOREIGN KEY(logo_image_id) REFERENCES organizations_images(id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE organizations ALTER COLUMN logo_image_id DROP NOT NULL;
ALTER TABLE organizations ALTER COLUMN logo_image_id SET DEFAULT NULL;

-- +migrate Down
ALTER TABLE organizations ALTER COLUMN logo_image_id SET NOT NULL;
ALTER TABLE organizations DROP CONSTRAINT "organizations_logo_image_id_fkey";
ALTER TABLE organizations RENAME logo_image_id TO logo;
ALTER TABLE organizations ALTER COLUMN logo TYPE VARCHAR(255);
