class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end
    @answer = @question.answers.build(params[:answer])
    @answer.user_id = @current_user.id

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end
    @tags = @question.tags.order(:id)
    @tag = @question.tags.build
    @taggings = Tagging.where(:tag_id => @tags.collect{|x| x.id},:question_id => params[:id]).order(:tag_id)
    @answer = @question.answers.find(params[:id])
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        # make other answers wrong
        if params[:answer][:correct]
          @question.answers.each do |a|
            if a != @answer
              a.correct = false
              a.save
            end
          end
        end
        format.html { render :template => 'questions/show', :id => @question.id, notice: 'Answer was successfully updated.'}
        #format.json { head :no_content }
        #redirect_to question_url(@question_id)
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])

    @answer.destroy

    respond_to do |format|
      format.html { redirect_to @question }
      format.json { head :no_content }
    end
  end
end