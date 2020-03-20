# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :members do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      foreign_key :organisation_id, :organisations, type: :uuid, null: false
      column :active, TrueClass, default: true
      column :accepted, TrueClass, default: false
      column :independent_contractor, TrueClass, default: false
      column :role, String, default: 'employee'
      column :created_at, Time, default: Sequel.function(:now)
      column :updated_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :members
  end
end
