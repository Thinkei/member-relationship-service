# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :members_teams do
      primary_key %i[team_id member_id], :uuid, default: Sequel.function(:uuid_generate_v4)

      foreign_key :team_id, :teams, type: :uuid, null: false
      foreign_key :member_id, :members, type: :uuid, null: false
    end
  end

  down do
    drop_table :members_teams
  end
end
