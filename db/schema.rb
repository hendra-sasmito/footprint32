# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150426122848) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "activity_type",               :null => false
    t.integer  "target_id",                   :null => false
    t.string   "target_type",   :limit => 20, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "activities", ["target_id", "target_type"], :name => "index_activities_on_target_id_and_target_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.string   "provider",     :null => false
    t.string   "uid",          :null => false
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name",                        :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "parent_id"
    t.integer  "places_count", :default => 0
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "category_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_category_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "category_hierarchies", ["descendant_id"], :name => "index_category_hierarchies_on_descendant_id"

  create_table "cities", :force => true do |t|
    t.integer "region_id",                            :null => false
    t.integer "country_id",                           :null => false
    t.string  "name",                                 :null => false
    t.float   "latitude"
    t.float   "longitude"
    t.integer "places_count",          :default => 0
    t.integer "favorite_cities_count", :default => 0
    t.integer "visited_cities_count",  :default => 0
    t.integer "reviews_count",         :default => 0
  end

  add_index "cities", ["country_id", "places_count"], :name => "index_cities_on_places_count"

  create_table "comments", :force => true do |t|
    t.text     "content",                        :null => false
    t.integer  "commentable_id",                 :null => false
    t.string   "commentable_type", :limit => 20, :null => false
    t.integer  "user_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type", "created_at"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "conversations", :force => true do |t|
    t.integer  "message_id", :null => false
    t.integer  "sender_id",  :null => false
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "conversations", ["message_id"], :name => "index_conversations_on_message_id"
  add_index "conversations", ["sender_id"], :name => "index_conversations_on_sender_id"

  create_table "countries", :force => true do |t|
    t.string  "name",                                     :null => false
    t.string  "code",         :limit => 2,                :null => false
    t.integer "cities_count",              :default => 0
  end

  create_table "events", :force => true do |t|
    t.string   "name",                                    :null => false
    t.integer  "creator_id",                              :null => false
    t.integer  "place_id",                                :null => false
    t.datetime "date",                                    :null => false
    t.integer  "privacy",     :limit => 1, :default => 0
    t.text     "description"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "events", ["creator_id", "date"], :name => "index_events_on_creator_id_and_date"
  add_index "events", ["place_id", "date"], :name => "index_events_on_place_id_and_date"

  create_table "favorite_cities", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "city_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorite_cities", ["city_id", "updated_at"], :name => "index_favorite_cities_on_city_id_and_updated_at"
  add_index "favorite_cities", ["user_id", "updated_at"], :name => "index_favorite_cities_on_user_id_and_updated_at"

  create_table "favorite_places", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorite_places", ["place_id", "updated_at"], :name => "index_favorite_places_on_place_id_and_updated_at"
  add_index "favorite_places", ["user_id", "updated_at"], :name => "index_favorite_places_on_user_id_and_updated_at"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "friend_id",   :null => false
    t.string   "status",      :null => false
    t.datetime "accepted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id"

  create_table "message_statuses", :force => true do |t|
    t.integer  "message_id", :null => false
    t.integer  "user_id",    :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "start_at"
  end

  add_index "message_statuses", ["message_id", "status"], :name => "index_message_statuses_on_message_id_and_status"
  add_index "message_statuses", ["user_id", "status"], :name => "index_message_statuses_on_user_id_and_status"

  create_table "messages", :force => true do |t|
    t.string   "subject",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photo_albums", :force => true do |t|
    t.integer  "creator_id",                                      :null => false
    t.string   "name",                                            :null => false
    t.text     "description"
    t.integer  "privacy",        :limit => 1,  :default => 0
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "default",                      :default => false
    t.integer  "albumable_id"
    t.string   "albumable_type", :limit => 20
  end

  add_index "photo_albums", ["albumable_id", "albumable_type"], :name => "index_photo_albums_on_albumable_id_and_albumable_type"
  add_index "photo_albums", ["creator_id"], :name => "index_photo_albums_on_creator_id"

  create_table "photos", :force => true do |t|
    t.integer  "creator_id",                       :null => false
    t.integer  "photo_album_id",                   :null => false
    t.text     "description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "photoable_id"
    t.string   "photoable_type",     :limit => 20
  end

  add_index "photos", ["creator_id", "updated_at"], :name => "index_photos_on_creator_id_and_updated_at"
  add_index "photos", ["photo_album_id", "updated_at"], :name => "index_photos_on_photo_album_id_and_updated_at"
  add_index "photos", ["photoable_id", "photoable_type", "updated_at"], :name => "index_photos_on_photoable_id"
  add_index "photos", ["photoable_type", "photoable_id", "updated_at"], :name => "index_photos_on_photoable_type"

  create_table "places", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "street"
    t.string   "postcode"
    t.float    "latitude",                             :null => false
    t.float    "longitude",                            :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "category_id"
    t.integer  "reviews_count",         :default => 0
    t.integer  "favorite_places_count", :default => 0
    t.integer  "visited_places_count",  :default => 0
    t.string   "description"
    t.integer  "city_id",                              :null => false
  end

  add_index "places", ["category_id"], :name => "index_places_on_category_id"
  add_index "places", ["city_id"], :name => "index_places_on_city_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name",                                            :null => false
    t.string   "last_name",                                             :null => false
    t.date     "birthdate"
    t.string   "gender",                 :limit => 1
    t.text     "about"
    t.integer  "profile_photo_id"
    t.integer  "location_id"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "time_zone"
    t.string   "language",                            :default => "en"
    t.integer  "hometown_id"
    t.integer  "profile_photo_offset_x", :limit => 2, :default => 0
    t.integer  "profile_photo_offset_y", :limit => 2, :default => 0
  end

  add_index "profiles", ["hometown_id"], :name => "index_profiles_on_hometown_id"
  add_index "profiles", ["location_id"], :name => "index_profiles_on_location_id"
  add_index "profiles", ["profile_photo_id"], :name => "index_profiles_on_profile_photo_id"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "regions", :force => true do |t|
    t.integer "country_id", :null => false
    t.string  "name"
  end

  add_index "regions", ["country_id"], :name => "index_regions_on_country_id"

  create_table "reports", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "reportable_id",                 :null => false
    t.string   "reportable_type", :limit => 20, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "reason",                        :null => false
    t.text     "comment"
  end

  add_index "reports", ["reportable_id", "reportable_type"], :name => "index_reports_on_reportable_id_and_reportable_type"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "review_photos", :force => true do |t|
    t.integer  "review_id",          :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "review_photos", ["review_id"], :name => "index_review_photos_on_review_id"

  create_table "review_votes", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "review_id",                 :null => false
    t.integer  "value",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "review_votes", ["review_id"], :name => "index_review_votes_on_review_id"
  add_index "review_votes", ["user_id"], :name => "index_review_votes_on_user_id"

  create_table "reviews", :force => true do |t|
    t.integer  "creator_id",                    :null => false
    t.text     "content",                       :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "reviewable_id",                 :null => false
    t.string   "reviewable_type", :limit => 10, :null => false
  end

  add_index "reviews", ["creator_id", "updated_at"], :name => "index_reviews_on_creator_id_and_updated_at"
  add_index "reviews", ["reviewable_id", "reviewable_type", "updated_at"], :name => "index_reviews_on_reviewable_id"
  add_index "reviews", ["reviewable_type", "reviewable_id", "updated_at"], :name => "index_reviews_on_reviewable_type"

  create_table "shares", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.string   "provider",                        :null => false
    t.boolean  "share_review", :default => false
    t.boolean  "share_event",  :default => false
    t.boolean  "share_photo",  :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "shares", ["user_id"], :name => "index_shares_on_user_id"

  create_table "trips", :force => true do |t|
    t.integer  "user_id",                                              :null => false
    t.string   "name",                                                 :null => false
    t.text     "description"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "datalog_file_name"
    t.string   "datalog_content_type"
    t.integer  "datalog_file_size"
    t.datetime "datalog_updated_at"
    t.boolean  "selected",                          :default => false
    t.integer  "privacy",              :limit => 1, :default => 0
  end

  add_index "trips", ["user_id"], :name => "index_trips_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "reviews_count",          :default => 0
    t.time     "deleted_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "visited_cities", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "city_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "visited_cities", ["city_id", "updated_at"], :name => "index_visited_cities_on_city_id_and_updated_at"
  add_index "visited_cities", ["user_id", "updated_at"], :name => "index_visited_cities_on_user_id_and_updated_at"

  create_table "visited_places", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "visited_places", ["place_id", "updated_at"], :name => "index_visited_places_on_place_id_and_updated_at"
  add_index "visited_places", ["user_id", "updated_at"], :name => "index_visited_places_on_user_id_and_updated_at"

end
