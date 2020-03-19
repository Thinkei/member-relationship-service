# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :members_teams do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)
      column :member_id, :uuid, null: false
      column :team_id, :uuid, null: false
    end
  end

  down do
    drop_table :members_teams
  end
end
