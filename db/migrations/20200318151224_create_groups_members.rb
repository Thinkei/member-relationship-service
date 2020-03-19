# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :groups_members do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      column :group_id, :uuid, null: false
      column :member_id, :uuid, null: false
    end
  end

  down do
    drop_table :groups_members
  end
end
