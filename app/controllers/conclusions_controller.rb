class ConclusionsController < ApplicationController
  # GET /conclusions
  # GET /conclusions.xml
  def index
    @conclusions = Conclusion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conclusions }
    end
  end

  # GET /conclusions/1
  # GET /conclusions/1.xml
  def show
    @conclusion = Conclusion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conclusion }
    end
  end

  # GET /conclusions/new
  # GET /conclusions/new.xml
  def new
    @conclusion = Conclusion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conclusion }
    end
  end

  # GET /conclusions/1/edit
  def edit
    @conclusion = Conclusion.find(params[:id])
  end

  # POST /conclusions
  # POST /conclusions.xml
  def create
    @conclusion = Conclusion.new(params[:conclusion])

    respond_to do |format|
      if @conclusion.save
        format.html { redirect_to(@conclusion, :notice => 'Conclusion was successfully created.') }
        format.xml  { render :xml => @conclusion, :status => :created, :location => @conclusion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conclusion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conclusions/1
  # PUT /conclusions/1.xml
  def update
    @conclusion = Conclusion.find(params[:id])

    respond_to do |format|
      if @conclusion.update_attributes(params[:conclusion])
        format.html { redirect_to(@conclusion, :notice => 'Conclusion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conclusion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conclusions/1
  # DELETE /conclusions/1.xml
  def destroy
    @conclusion = Conclusion.find(params[:id])
    @conclusion.destroy

    respond_to do |format|
      format.html { redirect_to(conclusions_url) }
      format.xml  { head :ok }
    end
  end
end
