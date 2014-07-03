class ProcessAppController < ApplicationController
  def index
    @process_apps = ProcessApp.all

    render "/process_app/index"
  end

  def show
    @process_app = ProcessApp.find(params[:id])

    render "/process_app/show"
  end
end
