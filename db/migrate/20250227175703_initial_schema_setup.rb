class InitialSchemaSetup < ActiveRecord::Migration[8.0]
  def change

    create_schema "heroku_ext"

    # These are extensions that must be enabled in order to support this database
    enable_extension "pg_catalog.plpgsql"
    enable_extension "pg_stat_statements"

    create_table "bill_categories", id: :serial, force: :cascade do |t|
      t.string "label", limit: 255, null: false
    end

    create_table "bill_types", id: :serial, force: :cascade do |t|
      t.string "label", limit: 255, null: false
      t.integer "bill_system_id", null: false
      t.text "description", null: false
      t.integer "bill_category_id", null: false
    end

    create_table "bills", id: :serial, force: :cascade do |t|
      t.string "short_title", limit: 255, null: false
      t.integer "bill_system_id", null: false
      t.boolean "is_act", default: false
      t.boolean "is_withdrawn", default: false
      t.boolean "is_defeated", default: false
      t.integer "originating_house_id"
      t.integer "current_house_id"
      t.integer "originating_session_id", null: false
      t.integer "bill_type_id", null: false
      t.datetime "updated", precision: nil, null: false
    end

    create_table "content_types", id: :serial, force: :cascade do |t|
      t.string "content_type", limit: 255, null: false
    end

    create_table "links", id: :serial, force: :cascade do |t|
      t.string "title", limit: 10000, null: false
      t.string "url", limit: 10000, null: false
      t.integer "content_length"
      t.string "source", limit: 20, null: false
      t.integer "bill_system_id", null: false
      t.integer "publication_id", null: false
      t.integer "content_type_id", null: false
    end

    create_table "parliamentary_houses", id: :serial, force: :cascade do |t|
      t.string "short_label", limit: 255, null: false
      t.string "label", limit: 255, null: false
    end

    create_table "publication_types", id: :serial, force: :cascade do |t|
      t.string "label", limit: 255, null: false
      t.integer "bill_system_id", null: false
      t.text "description"
    end

    create_table "publications", id: :serial, force: :cascade do |t|
      t.string "title", limit: 10000, null: false
      t.date "display_date", null: false
      t.integer "bill_system_id", null: false
      t.integer "parliamentary_house_id"
      t.integer "publication_type_id", null: false
      t.integer "bill_id", null: false
    end

    create_table "sessions", id: :serial, force: :cascade do |t|
      t.string "number", limit: 255, null: false
      t.date "start_on", null: false
      t.date "end_on", null: false
      t.string "commons_description", limit: 255, null: false
      t.string "lords_description", limit: 255, null: false
      t.integer "parliament_number", null: false
      t.integer "session_number", null: false
      t.integer "bill_system_id", null: false
    end

    add_foreign_key "bill_types", "bill_categories", name: "fk_bill_category"
    add_foreign_key "bills", "parliamentary_houses", column: "current_house_id", name: "fk_bill_type"
    add_foreign_key "bills", "parliamentary_houses", column: "current_house_id", name: "fk_current_house"
    add_foreign_key "bills", "parliamentary_houses", column: "originating_house_id", name: "fk_originating_house"
    add_foreign_key "bills", "sessions", column: "originating_session_id", name: "fk_originating_session"
    add_foreign_key "links", "content_types", name: "fk_content_type"
    add_foreign_key "links", "publications", name: "fk_publication"
    add_foreign_key "publications", "bills", name: "fk_bill"
    add_foreign_key "publications", "parliamentary_houses", name: "fk_house"
    add_foreign_key "publications", "publication_types", name: "fk_publication_type"
  end
end
