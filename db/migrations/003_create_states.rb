Sequel.migration do
  up do
    create_table :states do
      uuid_primary_key

      citext :name, null: false

      timestamps
      lock_version

      full_text_index :name
    end

    create_timestamp_trigger :states
  end

  down do
    drop_timestamp_trigger :states
    drop_table :states
  end
end
