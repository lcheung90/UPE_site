class QuestionsController < ApplicationController
  def index
    if params[:unanswered]
      @questions = Question.includes("answers").where(answers: {question_id: nil}).order("questions.created_at DESC")
    else
      @questions = Question.order("created_at DESC")
    end
    @tags = Tag.order("name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  def show
    @question = Question.find(params[:id])
    @question.increment!(:view_count)
    @user = @question.user
    @answer = Answer.new
    @tags = @question.tags.order(:id)
    @tag = @question.tags.build
    @taggings = Tagging.where(:tag_id => @tags.collect{|x| x.id},:question_id => params[:id]).order(:tag_id)
    @score = @question.plusminus
  end

  def new
    @question = @current_user.questions.build
  end

  def create
    @question = @current_user.questions.build(params[:question])#User.find(params[:user_id]).questions.build(params[:question])
    @question[:view_count] = 0
    @question[:score] = 0
    if @question.save
      flash[:notice] = "Question successfully added"
      redirect_to user_url(@current_user.username)
    else
      render action: "new"
    end
  end

  def edit
    @question = @current_user.questions.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Question sucessfully updated"
      redirect_to question_url(params[:id])
    else
      render action: "edit"
    end
  end

  def destroy
    @question = @current_user.questions.find(params[:id])
    if @question.destroy
      flash[:notice] = "Question sucessfully deleted"
      redirect_to user_url(@current_user.username)
    else
      render action: "show"
    end
  end

  def question_vote_up
    user = User.find_by_id(params[:user_id])
    question = Question.find_by_id(params[:question_id])
    if user.voted_against?(question)
    user.unvote_for(question)
    elsif user.voted_for?(question)
    redirect_to question_url(question) and return
    else
    user.vote_for(question)
    end
    redirect_to question_url(question)
  end

  def question_vote_down
    user = User.find_by_id(params[:user_id])
    question = Question.find_by_id(params[:question_id])
    if user.voted_for?(question)
      user.unvote_for(question)
    elsif user.voted_against?(question)
    redirect_to question_url(question) and return
    else
    user.vote_against(question)
    end
    redirect_to question_url(question)
  end
end
