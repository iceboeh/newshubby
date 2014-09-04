def set_link
  @newsroom = Newsroom.friendly.find(params[:id])
end