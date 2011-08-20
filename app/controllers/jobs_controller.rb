class JobsController < ApplicationController
  load_and_authorize_resource

  #before_filter :get_forum
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = current_user.jobs

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])
    @forum = @job.forum
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @forum = @job.forum
    @handlers = @job.handlers.map{|handler| handler.nick}
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])
    @job.author = current_user
    @job.status = :opened
    
    new_handlers = registered_users(params[:handlers].split(" ").uniq)

    new_handlers.each do |handler|
        @job.handlers << handler
    end

    respond_to do |format|
      unless not_registered_users?(params[:handlers].split(" ").uniq, @job)
        if @job.save
          format.html { redirect_to(@job.forum, :notice => "Job ##{@job.id} was successfully created.") }
          format.xml  { render :xml => @job, :status => :created, :location => @job }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
        end
      else
        @handlers = @job.handlers.map{|handler| handler.nick}
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    @forum = @job.forum

    received_users = params[:handlers].split(" ").uniq

    new_assigned_and_registered_handlers ||= []
    registered_users(received_users).each {
      |handler|
        new_assigned_and_registered_handlers << handler if handler.assigned_to? @forum
    }

    handlers_to_add = new_assigned_and_registered_handlers - @job.handlers
    handlers_to_delete = @job.handlers - new_assigned_and_registered_handlers

    handlers_to_add.each do |handler|
        @job.handlers << handler
    end

    handlers_to_delete.each do |handler|
      @job.handlers.delete(handler)
    end

    if !params[:conclusion].empty?
      conclusion = Conclusion.new()
      conclusion.description = current_user.nick + "\/"+ Time.now().strftime("%d.%m.%Y %H:%M") + ": " + params[:conclusion].to_s
      @job.conclusions << conclusion
    end

    respond_to do |format|
      unless not_registered_users?(received_users, @job) || not_assigned_users?(registered_users(received_users), @forum, @job)
        if @job.update_attributes(params[:job])
          format.html { redirect_to(@job.forum, :notice =>"Job #{@job.id} was successfully updated.")}
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
        end
      else
        @handlers = @job.handlers.map{|handler| handler.nick}
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
