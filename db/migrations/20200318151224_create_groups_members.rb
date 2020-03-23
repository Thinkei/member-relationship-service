# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :groups_members do
      primary_key %i[group_id member_id], :uuid, default: Sequel.function(:uuid_generate_v4)

      foreign_key :group_id, :groups, type: :uuid, null: false
      foreign_key :member_id, :members, type: :uuid, null: false
    end
  end

  down do
    drop_table :groups_members
  end
end
