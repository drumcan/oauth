class CreatePartnerMerchants < ActiveRecord::Migration
  def up
    create_table :partner_merchants do |t|
      t.string :merchant_id
      t.string :access_token
      t.string :refresh_token
      t.string :expiration_date
  end
end

  def down
    drop_table :partner_merchants
  end
end
