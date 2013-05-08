class TaggingsController < ApplicationController
  def create
    @tag = Tag.find_or_create_by_name(params[:tag][:name])
    @question = Question.find(params[:question_id])
    @tagging = Tagging.new

    @tagging.question_id = @question.id
    @tagging.tag_id = @tag.id

    if @tagging.save
      flash[:notice] = "Tag "+@tagging.tag.name+" successfully added"
      redirect_to question_url(@tagging[:question_id])
    else
      flash[:notice] = "Unable to create "+ params[:tag][:name]+" tag"
      redirect_to question_url(@tagging[:question_id])
    end
  end

  def destroy
    @tagging = Tagging.find(params[:id])
    tagName = @tagging.tag[:name]
    if @tagging.destroy
      flash[:notice] = "Tag "+tagName+" successfully removed"
      redirect_to question_url(params[:question_id])
    end
  end
end