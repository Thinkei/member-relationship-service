# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :member_managers do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      foreign_key :manager_id, :members, type: :uuid, null: false
      foreign_key :member_id, :members, type: :uuid, null: false
      column :level, Integer
      column :primary_manager, Integer
      unique %i[manager_id member_id]
      unique %i[member_id level]
      column :created_at, Time, default: Sequel.function(:now)
      column :updated_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :member_managers
  end
end
