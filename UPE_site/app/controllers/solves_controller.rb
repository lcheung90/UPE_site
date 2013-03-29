class SolvesController < ApplicationController
  # GET /solves
  # GET /solves.json
  def index
    @solves = Solf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @solves }
    end
  end

  # GET /solves/1
  # GET /solves/1.json
  def show
    @solf = Solf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @solf }
    end
  end

  # GET /solves/new
  # GET /solves/new.json
  def new
    @solf = Solf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @solf }
    end
  end

  # GET /solves/1/edit
  def edit
    @solf = Solf.find(params[:id])
  end

  # POST /solves
  # POST /solves.json
  def create
    @solf = Solf.new(params[:solf])

    respond_to do |format|
      if @solf.save
        format.html { redirect_to @solf, notice: 'Solf was successfully created.' }
        format.json { render json: @solf, status: :created, location: @solf }
      else
        format.html { render action: "new" }
        format.json { render json: @solf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /solves/1
  # PUT /solves/1.json
  def update
    @solf = Solf.find(params[:id])

    respond_to do |format|
      if @solf.update_attributes(params[:solf])
        format.html { redirect_to @solf, notice: 'Solf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @solf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solves/1
  # DELETE /solves/1.json
  def destroy
    @solf = Solf.find(params[:id])
    @solf.destroy

    respond_to do |format|
      format.html { redirect_to solves_url }
      format.json { head :no_content }
    end
  end
end
