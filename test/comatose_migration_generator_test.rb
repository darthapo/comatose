require File.dirname(__FILE__) + '/test_helper'
#require 'rails_generator'
#require 'rails_generator/scripts/generate'
 
class MigrationGeneratorTest < Test::Unit::TestCase
 
  def setup
    FileUtils.mkdir_p(fake_Rails.root)
    @original_files = file_list
  end
 
  def teardown
    ActiveRecord::Base.pluralize_table_names = true
    FileUtils.rm_r(fake_Rails.root)
  end
 
  def test_generates_correct_file_name
    Rails::Generator::Scripts::Generate.new.run(["comatose_migration", "some_name_nobody_is_likely_to_ever_use_in_a_real_migration"],
      :destination => fake_Rails.root)
    new_file = (file_list - @original_files).first
    assert_match /add_comatose_fields_to_some_name_nobody_is_likely_to_ever_use_in_a_real_migrations/, new_file
    assert_match /add_column :some_name_nobody_is_likely_to_ever_use_in_a_real_migrations do |t|/, File.read(new_file)
  end
 
  def test_pluralizes_properly
    ActiveRecord::Base.pluralize_table_names = false
    Rails::Generator::Scripts::Generate.new.run(["comatose_migration", "some_name_nobody_is_likely_to_ever_use_in_a_real_migration"],
      :destination => fake_Rails.root)
    new_file = (file_list - @original_files).first
    assert_match /add_comatose_fields_to_some_name_nobody_is_likely_to_ever_use_in_a_real_migration/, new_file
    assert_match /add_column :some_name_nobody_is_likely_to_ever_use_in_a_real_migration do |t|/, File.read(new_file)
  end
 
  private
    def fake_Rails.root
      File.join(File.dirname(__FILE__), 'Rails.root')
    end
 
    def file_list
      Dir.glob(File.join(fake_Rails.root, "db", "migrate", "*"))
    end
 
end
