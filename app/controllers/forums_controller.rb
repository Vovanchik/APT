class ForumsController < ApplicationController
  load_and_authorize_resource

  # GET /forums
  # GET /forums.xml
  def index
    if current_user.admin?
      @forums = Forum.find(:all).paginate(:page => params[:page], :per_page => NUMBER_ITEMS_PER_PAGE)
    else
      @forums = current_user.forums.paginate(:page => params[:page], :per_page => NUMBER_ITEMS_PER_PAGE)
    end;

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @forum = Forum.find(params[:id])
    @users = @forum.users.paginate(:page => params[:page], :per_page => NUMBER_ITEMS_PER_PAGE)
    
    if @forum.private?
      @jobs = @forum.jobs.find_all_by_author_id(current_user.id).paginate(:page => params[:page], :per_page => NUMBER_ITEMS_PER_PAGE)
    else
      @jobs = @forum.jobs.paginate(:page => params[:page], :per_page => NUMBER_ITEMS_PER_PAGE)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
    @user_nicks = @forum.users.map{|user| user.nick}.join(' ')
    @users = User.find(:all)
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])
    @forum.author = current_user

    new_users = registered_users(params[:users].split(" ").uniq)

    new_users.each do |user|
        @forum.users << user
    end
    
    respond_to do |format|
      unless not_registered_users?(params[:users].split(" ").uniq, @forum)
        if @forum.save
          format.html { redirect_to(forums_path, :notice => "Forum #{@forum.name} was successfully created.")}
          format.xml  { render :xml => @forum, :status => :created, :location => @forum }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
        end
      else
        @user_nicks = new_users.map{|user| user.nick}.join(' ')
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])

    new_users = registered_users(params[:users].split(" ").uniq)
    
    users_to_add =new_users - @forum.users
    users_to_delete = @forum.users - new_users

    users_to_add.each do |user|
      @forum.users << user
    end

    users_to_delete.each do |user|
      @forum.users.delete(user)
    end
    
    respond_to do |format|
      unless not_registered_users?(params[:users].split(" ").uniq, @forum)
        if @forum.update_attributes(params[:forum])
          format.html { redirect_to(forums_path, :notice => "Forum #{@forum.name} was successfully updated.") }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit"}
          format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
        end
      else
        @user_nicks = @forum.users.map{|user| user.nick}.join(' ')
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
   
    begin
      @forum.destroy
      respond_to do |format|
        format.html { redirect_to(forums_url, :notice => "Forum #{@forum.name} was successfully deleted.") }
        format.xml  { head :ok }
      end
    rescue ActiveRecord::DeleteRestrictionError
      respond_to do |format|
        format.html { redirect_to(forums_url, :flash => {:alert => "Forum #{@forum.name} cann`t be deleted due to dependencies to APs."}) }
        format.xml  { head :ok }
      end
    end
  end
end
