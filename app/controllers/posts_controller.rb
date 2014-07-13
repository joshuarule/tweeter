class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    #finds record in db that matches url
    @post = Post.find(params[:id])
    # raise 'foo' creates an error
  end

  def new
    before_filter authenticate_user! if !current_user
    @post = Post.new
  end

  def edit
    before_filter authenticate_user! if !current_user
    @post = Post.find(params[:id])
  end

  def create
    # excutes when form is submit on new.html post
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    if @post.save
      # send us to the url where the post is created
      # post path needs the @post to know the url
      redirect_to post_path(@post), notice: "Post Saved!"
    else
      # if it doesn't work then render the new view
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy

    redirect_to posts_path
  end

  # telling rails it's ok to submit data to the database
  # allow post model to permit the content column to be updated
  private
    def post_params
      params.require(:post).permit(:content)
    end
end
