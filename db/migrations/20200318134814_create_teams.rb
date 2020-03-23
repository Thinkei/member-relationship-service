# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :teams do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      foreign_key :organisation_id, :organisations, type: :uuid, null: false
      foreign_key :leader_id, :members, type: :uuid
      column :name, String
      column :created_at, Time, default: Sequel.function(:now)
      column :updated_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :teams
  end
end
