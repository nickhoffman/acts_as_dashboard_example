class DashboardsController < ApplicationController
  # NOTE: Remove this line if you don't mind restarting the server after modifying this class.
  include ActsAsDashboard

  acts_as_dashboard

  dashboard_number do |d|
    d.name            = :number_of_projects
    d.title           = 'Number of Projects'
    d.update_interval = '5s'
    d.data            {Project.count.to_s}
  end

  dashboard_number do |d|
    d.name            = :number_of_tasks
    d.title           = 'Number of Tasks'
    d.update_interval = '5s'
    d.data            {Task.count.to_s}
  end

  dashboard_short_messages do |d|
    d.name            = :newest_task_in_improve_acts_as_dashboard
    d.title           = 'Newest Tasks In: Improve acts_as_dashboard'
    d.update_interval = '5s'
    d.data            {Project.find_by_name('Improve acts_as_dashboard').tasks.last.name}
  end

  dashboard_line_graph do |d|
    d.name            = :tasks_per_project
    d.title           = 'Tasks Per Project'
    d.update_interval = '15s'
    d.line_colours    = %w(blue)
    d.x_axis          = :numbers
    d.data do
      data = []
      Project.all.each_with_index do |p, i|
        data.push [i, p.tasks.count]
      end

      data.to_json
    end
  end
end
