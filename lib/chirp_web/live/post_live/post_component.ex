defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~L"""
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">      <div id="post-<%= @post.id %>" class="post">
        <div class="row">
          <div class="column column-10">
            <div class="post-avatar">
              <img src="https://via.placeholder.com/100" alt="<%= @post.username %>">
            </div>
          </div>
          <div class="column column-90 post-body">
            <b><span class="user_name">@<%= @post.username %></span></b>
            <br>
            <p><%= @post.body %></p>
          </div>
        </div>
        <div class="row">
          <div class="column">
            <a href="#" phx-click="like" phx-target="<%= @myself %>">
              <i class="fa fa-heart-o" aria-hidden="true" style="color:gray"></i> <%= @post.likes_count %>
            </a>
          </div>
          <div class="column">
            <a href="#" phx-click="repost" phx-target="<%= @myself %>">
              <i class="fa fa-retweet" aria-hidden="true" style="color:gray"></i> <%= @post.reposts_count %>
            </a>
          </div>
          <div class="column">
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
              <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
            <% end %>
            <span>&nbsp;&nbsp;</span>
            <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
              <i class="fa fa-trash-o" aria-hidden="true"></i>
            <% end %>
          </div>
        </div>
        <br>
      </div>

    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end

end
