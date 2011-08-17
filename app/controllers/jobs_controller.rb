class JobsController < ApplicationController

  before_filter :get_forum
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = @forum.jobs

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

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
    @handlers = @job.handlers.map{|handler| handler.nick}
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])
    @job.forum = @forum

    @job.author = current_user
    
    new_handlers =find_received_users(params[:handlers].split(" ").uniq)

    new_handlers.each do |handler|
        @job.handlers << handler
    end

    respond_to do |format|
      if @job.save
        flash_message :notice, "Job #{@job.id} successfuly created"
        format.html { redirect_to (forum_path(@forum) )}
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])

    new_handlers =find_received_users(params[:handlers].split(" ").uniq)

    handlers_to_add =new_handlers - @job.handlers
    handlers_to_delete = @job.handlers - new_handlers

    handlers_to_add.each do |handler|
        @job.handlers << handler
    end

    handlers_to_delete.each do |handler|
      @job.handlers.delete(handler)
    end
    
    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to (forum_path(@forum) )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
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
