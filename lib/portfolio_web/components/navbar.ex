defmodule PortfolioWeb.Components.NavBar do
  use Phoenix.Component
  use Gettext, backend: PortfolioWeb.Gettext
  use PortfolioWeb, :verified_routes

  alias Phoenix.LiveView.JS

  def nav_bar(assigns) do
    ~H"""
    <header class="relative h-full flex items-center justify-between px-5 py-5 text-sm border-b sm:px-6 lg:px-8 border-zinc-200 dark:border-zinc-700">
      <a href={~p"/"} class="flex-1">
        <img src={~p"/images/logo.svg"} width="36" />
      </a>
      
      <nav class="relative h-full flex-1 justify-center items-center hidden gap-2 px-5 text-base md:flex">
        <.link
          navigate={~p"/"}
          class={[
            "px-5 py-2",
            if(@current_uri.path == "/",
              do: "text-indigo-700 dark:text-indigo-300 font-medium",
              else: "text-zinc-500 dark:text-zinc-400"
            )
          ]}
        >
          {gettext("Home")}
        </.link>
        
        <.link
          navigate={~p"/blog"}
          class={[
            "px-5 py-2",
            if(@current_uri.path == "/blog",
              do: "text-indigo-700 dark:text-indigo-300 font-medium",
              else: "text-zinc-500 dark:text-zinc-400"
            )
          ]}
        >
          {gettext("Blog")}
        </.link>
        
        <.link
          navigate={~p"/contact"}
          class={[
            "px-5 py-2",
            if(@current_uri.path == "/contact",
              do: "text-indigo-700 dark:text-indigo-300 font-medium",
              else: "text-zinc-500 dark:text-zinc-400"
            )
          ]}
        >
          {gettext("Contact")}
        </.link>
      </nav>
      
      <div class="relative h-full flex-1 hidden md:flex justify-end items-center gap-5">
        <form
          :for={locale <- Gettext.known_locales(PortfolioWeb.Gettext)}
          method="post"
          action={~p"/locale"}
          class="relative"
        >
          <input type="hidden" name="_csrf_token" value={Phoenix.Controller.get_csrf_token()} />
          <input type="hidden" name="locale" value={locale} />
          <input type="hidden" name="to" value={@current_uri.path} />
          <button
            type="submit"
            class={[
              "uppercase font-medium",
              if(Gettext.get_locale(PortfolioWeb.Gettext) == locale,
                do: "text-indigo-700 dark:text-indigo-300 font-medium",
                else: "text-zinc-500 dark:text-zinc-400"
              )
            ]}
          >
            {locale}
          </button>
        </form>
        
        <div class="w-px h-full bg-zinc-300"></div>
        
        <button phx-click={JS.dispatch(%JS{}, "toggle-darkmode")} class="h-full">
          <Heroicons.icon name="sun" class="w-6 dark:hidden" />
          <Heroicons.icon name="moon" class="w-6 hidden dark:block text-white" />
        </button>
      </div>
      
      <div class="contents md:hidden">
        <button phx-click={JS.show(to: "#mobile-nav")}>
          <Heroicons.icon name="bars-2" type="outline" class="w-6 dark:text-zinc-100" />
        </button>
        
        <aside
          id="mobile-nav"
          class="fixed top-0 left-0 z-10 flex-col items-start hidden w-full h-full gap-10 bg-white dark:bg-zinc-800"
        >
          <header class="relative flex items-center justify-between px-5 py-5 text-sm border-b sm:px-6 lg:px-8 border-zinc-200 dark:border-zinc-700">
            <.link patch={~p"/"}>
              <img src={~p"/images/logo.svg"} width="36" />
            </.link>
            
            <button phx-click={JS.hide(to: "#mobile-nav")}>
              <Heroicons.icon name="x-mark" type="outline" class="w-6 dark:text-zinc-100" />
            </button>
          </header>
          
          <div class="relative flex flex-col gap-10 mx-auto max-w-xs mt-5">
            <nav class="flex flex-col gap-5 p-5">
              <.link
                patch={~p"/"}
                class={[
                  "text-xl",
                  if(@current_uri.path == "/",
                    do: "text-indigo-700 dark:text-indigo-300 font-medium",
                    else: "text-zinc-500 dark:text-zinc-400"
                  )
                ]}
              >
                {gettext("Home")}
              </.link>
              
              <.link
                patch={~p"/blog"}
                class={[
                  "text-xl",
                  if(@current_uri.path == "/blog",
                    do: "text-indigo-700 dark:text-indigo-300 font-medium",
                    else: "text-zinc-500 dark:text-zinc-400"
                  )
                ]}
              >
                {gettext("Blog")}
              </.link>
              
              <.link
                patch={~p"/contact"}
                class={[
                  "text-xl",
                  if(@current_uri.path == "/contact",
                    do: "text-indigo-700 dark:text-indigo-300 font-medium",
                    else: "text-zinc-500 dark:text-zinc-400"
                  )
                ]}
              >
                {gettext("Contact")}
              </.link>
            </nav>
            
            <div class="relative flex flex-col justify-center items-center gap-5">
              <div class="relative flex justify-center items-center gap-5">
                <span class="dark:text-zinc-100 text-base mr-5">{gettext("Locale")}</span>
                <form
                  :for={locale <- Gettext.known_locales(PortfolioWeb.Gettext)}
                  method="post"
                  action={~p"/locale"}
                  class="relative"
                >
                  <input type="hidden" name="_csrf_token" value={Phoenix.Controller.get_csrf_token()} />
                  <input type="hidden" name="locale" value={locale} />
                  <input type="hidden" name="to" value={@current_uri.path} />
                  <button
                    type="submit"
                    class={[
                      "uppercase font-medium",
                      if(Gettext.get_locale(PortfolioWeb.Gettext) == locale,
                        do: "text-indigo-700 dark:text-indigo-300 font-medium",
                        else: "text-zinc-500 dark:text-zinc-400"
                      )
                    ]}
                  >
                    {locale}
                  </button>
                </form>
              </div>
              
              <div class="relative flex justify-center items-center gap-5">
                <p class="dark:text-zinc-100 text-base mr-5 h-full">{gettext("Theme")}</p>
                
                <button phx-click={JS.dispatch(%JS{}, "toggle-darkmode")}>
                  <Heroicons.icon name="sun" class="w-6 dark:hidden" />
                  <Heroicons.icon name="moon" class="w-6 hidden dark:block text-white" />
                </button>
              </div>
            </div>
          </div>
        </aside>
      </div>
    </header>
    """
  end
end
