# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :teams do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      column :name, String
      column :organisation_id, :uuid, null: false
      column :leader_id, :uuid
      column :created_at, Time, default: Sequel.function(:now)
      column :updated_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :teams
  end
end
