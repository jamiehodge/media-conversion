Sequel.migration do
  up do
    create_table :conversions do
      uuid_primary_key

      uuid_foreign_key :converter_id, :converters
      uuid_foreign_key :state_id, :states

      uuid :resource_id, null: false

      float :progress, default: 0.0, null: false

      timestamps
      lock_version
    end

    create_timestamp_trigger :conversions
  end

  down do
    drop_timestamp_trigger :conversions
    drop_table :conversions
  end
end
