class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.find_by_name(params[:id])
    @questions = Question.find_all_by_id(@tag.question_ids)
    #@questionsWithTag = Tag.find_by_name(params[:id]).questions
  end
end