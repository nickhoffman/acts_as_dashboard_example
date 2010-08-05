class AddProjectIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :project_id, :integer
  end

  def self.down
    remove_columns :tasks, :project_id
  end
end
