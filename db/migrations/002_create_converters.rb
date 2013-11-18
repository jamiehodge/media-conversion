Sequel.migration do
  up do
    create_table :converters do
      uuid_primary_key

      citext :name, null: false, unique: true
      citext :extension, null: false

      column :command, "citext[]", null: false
      column :types,   "citext[]", null: false

      timestamps
      lock_version

      full_text_index :name
    end

    create_timestamp_trigger :converters
  end

  down do
    drop_timestamp_trigger :converters
    drop_table :converters
  end
end
