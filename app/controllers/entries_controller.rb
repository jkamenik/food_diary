class EntriesController < ApplicationController
  include EntriesHelper
  before_filter :set_date
  
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.find_all_by_time params[:date]
    @entry   ||= Entry.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to(:action => :index, :notice => 'Entry was successfully created.') }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html do
          @entries = Entry.find_all_by_time params[:date]
          render :action => "index"
        end
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to(@entry, :notice => 'Entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.xml  { head :ok }
    end
  end
  
private
  def set_date
    params[:date] ||= todays_date
  end
end
