defmodule PortfolioWeb.Components.NavBar do
  use PortfolioWeb, :html

  def nav_bar(assigns) do
    ~H"""
    <header class="relative flex items-center justify-between px-5 py-5 text-sm border-b sm:px-6 lg:px-8 border-zinc-200">
      <a href={~p"/"}>
        <img src={~p"/images/logo.svg"} width="36" />
      </a>
      
      <nav class="items-center hidden gap-2 px-5 text-base md:flex">
        <a
          href={~p"/"}
          class={[
            "px-5 py-2",
            if(@conn.request_path == "/", do: "text-indigo-700 font-medium", else: "text-zinc-600")
          ]}
        >
          {gettext("Home")}
        </a>
        
        <a
          href={~p"/blog"}
          class={[
            "px-5 py-2",
            if(@conn.request_path == "/blog",
              do: "text-indigo-700 font-medium",
              else: "text-zinc-600"
            )
          ]}
        >
          {gettext("Blog")}
        </a>
        
        <a
          href={~p"/contact"}
          class={[
            "px-5 py-2",
            if(@conn.request_path == "/contact",
              do: "text-indigo-700 font-medium",
              else: "text-zinc-600"
            )
          ]}
        >
          {gettext("Contact")}
        </a>
      </nav>
      
      <div class="flex items-center gap-5">
        <form
          :for={locale <- Gettext.known_locales(PortfolioWeb.Gettext)}
          method="post"
          action={~p"/locale"}
          class="relative"
        >
          <input type="hidden" name="_csrf_token" value={Phoenix.Controller.get_csrf_token()} />
          <input type="hidden" name="locale" value={locale} />
          <input type="hidden" name="to" value={@conn.request_path} />
          <button
            type="submit"
            class={[
              "uppercase font-medium",
              if(Gettext.get_locale(PortfolioWeb.Gettext) == locale,
                do: "text-indigo-700",
                else: "text-zinc-600"
              )
            ]}
          >
            {locale}
          </button>
        </form>
      </div>
      
      <div class="contents md:hidden">
        <button phx-click={JS.show(to: "#mobile-nav")}>
          <Heroicons.icon name="bars-2" type="outline" class="w-6" />
        </button>
        
        <aside
          id="mobile-nav"
          class="fixed top-0 left-0 z-10 flex-col items-start hidden w-full h-full gap-10 bg-white"
        >
          <header class="relative flex items-center justify-between px-5 py-5 text-sm border-b sm:px-6 lg:px-8 border-zinc-200">
            <a href={~p"/"}>
              <img src={~p"/images/logo.svg"} width="36" />
            </a>
            
            <button phx-click={JS.hide(to: "#mobile-nav")}>
              <Heroicons.icon name="x-mark" type="outline" class="w-6" />
            </button>
          </header>
          
          <nav class="flex flex-col gap-5 p-5">
            <a href={~p"/"} class="text-xl">{gettext("Home")}</a>
            <a href={~p"/blog"} class="text-xl">{gettext("Blog")}</a>
            <a href={~p"/contact"} class="px-5 py-2 text-lg text-white bg-indigo-700 rounded-lg">
              {gettext("Contact")}
            </a>
          </nav>
        </aside>
      </div>
    </header>
    """
  end
end
