Sequel.migration do
  change do
    create_table(:events) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :parser, "text"
      column :partition, "text"
      column :topic, "text"
      column :offset, "integer"
      column :event, "text"
      column :uuid, "uuid"
      column :data, "jsonb"
      column :create_time, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :receive_time, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP

      primary_key [:id]
    end

    create_table(:schema_migrations) do
      column :filename, "text", :null=>false

      primary_key [:filename]
    end
  end
end
