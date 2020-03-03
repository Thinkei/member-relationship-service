# NOTE: This is an example migration, please remove it
Sequel.migration do
  up do
    create_table :events do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :name, String
      column :uuid, :uuid
      column :create_time, Time, default: Sequel.function(:now)
      column :receive_time, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :events
  end
end
