class CreateDnsRecordsRelatedHostnamesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :dns_records, :related_hostnames do |t|
      t.index :dns_record_id
      t.index :related_hostname_id
    end
  end
end
