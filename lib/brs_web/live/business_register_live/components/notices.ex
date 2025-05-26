defmodule BrsWeb.BusinessRegisterLive.Components.Notices do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="mt-4 px-0 sm:px-0 ">
        <p class="text-lg sm:text-2xl font-medium leading-none text-primary-500 mb-1">
          Initial Notice
        </p>

        <p class="text-sm mt-0 text-gray-500">
          For amendments and cancellation go to the secured creditors page and make changes to the specific notice.
        </p>
        <hr class="text-primary-910 mt-[10px] mb-4" />
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-1 gap-3">
        <div class="px-3 py-4 sm:pl-6 sm:pr-4 sm:py-4 lg:min-h-[74px] bg-white border rounded-lg border-primary-910 flex flex-row justify-between items-center">
          <p class="text-base font-medium text-primary-500 capitalize">Initial Notice</p>
          <div class="flex flex-col justify-center sm:mt-0 sm:ml-4">
            <a
              class="ml-3 items-center min-w-[70px] text-center px-3.5 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-500 hover:bg-primary-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-100"
              href="/registries/mpsr/services/3/apply/24"
              type="button"
            >
              Apply
            </a>
          </div>
        </div>
      </div>
      <div class="mt-4 px-0 sm:px-0 mt-[30px]">
        <p class="text-lg sm:text-2xl font-medium leading-none text-primary-500 mb-1">
          Your notices
        </p>

        <p class="text-sm mt-0 text-gray-500">
          This is a record of all your notices
        </p>
        <hr class="text-primary-910 mt-[10px]" />
      </div>
      <div class="flex flex-col mb-4">
        <div class="sm:overflow-auto mt-4 lg:overflow-visible">
          <div class="bg-white  border border-primary-910 rounded-lg">
            <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center space-y-3 sm:space-y-0 px-4 py-3 border-b border-primary-910">
              <form
                action=""
                class="flex-1 flex flex-col sm:flex-row justify-between sm:items-center sm:space-x-3 space-y-3
        sm:space-y-0"
                method="get"
              >
                <div class="rounded-lg w-full">
                  <label for="search" class="sr-only">Search</label>
                  <div class="relative text-gray-400 focus-within:text-gray-600">
                    <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                      <svg
                        class="h-5 w-5"
                        x-description="Heroicon name: mini/magnifying-glass"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        aria-hidden="true"
                      >
                        <path
                          fill-rule="evenodd"
                          d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                          clip-rule="evenodd"
                        >
                        </path>
                      </svg>
                    </div>
                    <input
                      class="block w-full rounded-lg border border-gray-300 bg-white py-2 pl-10 pr-3 leading-5 text-gray-900
            placeholder-gray-500 focus:border-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-primary-500
            sm:text-sm"
                      id="q"
                      name="q"
                      placeholder="Enter Application Number to Search..."
                      type="search"
                    />
                  </div>
                </div>
                <button
                  class="inline-flex items-center justify-center sm:w-32 rounded-md border border-gray-300 bg-white px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
                  type="submit"
                >
                  <svg
                    class="h-5 w-5 text-gray-400"
                    x-description="Heroicon name: mini/magnifying-glass"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                      clip-rule="evenodd"
                    >
                    </path>
                  </svg>
                  <span>Search</span>
                </button>
              </form>
            </div>

            <div class="flex flex-col justify-center items-center rounded-lg py-5 sm:py-7">
              <div class="inline-flex flex-col justify-center items-center">
                <div class="flex items-center justify-center mb-5">
                  <svg
                    width="211"
                    height="150"
                    viewBox="0 0 211 150"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M107.372 150C148.794 150 182.372 116.421 182.372 75C182.372 33.5786 148.794 0 107.372 0C65.951 0 32.3723 33.5786 32.3723 75C32.3723 116.421 65.951 150 107.372 150Z"
                      fill="#E2E3E9"
                    >
                    </path>
                    <g filter="url(#filter0_d_6032_72695)">
                      <path
                        d="M56.6915 58.1914H200.308C201.719 58.1914 203.072 58.7518 204.07 59.7493C205.067 60.7469 205.628 62.0998 205.628 63.5106V90.1063C205.628 91.517 205.067 92.87 204.07 93.8675C203.072 94.865 201.719 95.4254 200.308 95.4254H56.6915C55.2807 95.4254 53.9278 94.865 52.9303 93.8675C51.9327 92.87 51.3723 91.517 51.3723 90.1063V63.5106C51.3723 62.0998 51.9327 60.7469 52.9303 59.7493C53.9278 58.7518 55.2807 58.1914 56.6915 58.1914Z"
                        fill="white"
                      >
                      </path>
                    </g>
                    <path
                      d="M124.723 67H97.0638C95.3012 67 93.8723 68.4289 93.8723 70.1915C93.8723 71.9541 95.3012 73.383 97.0638 73.383H124.723C126.486 73.383 127.915 71.9541 127.915 70.1915C127.915 68.4289 126.486 67 124.723 67Z"
                      fill="#D1D5DB"
                    >
                    </path>
                    <path
                      d="M143.872 79H97.0638C95.3012 79 93.8723 80.4289 93.8723 82.1915C93.8723 83.9541 95.3012 85.383 97.0638 85.383H143.872C145.635 85.383 147.064 83.9541 147.064 82.1915C147.064 80.4289 145.635 79 143.872 79Z"
                      fill="#EAECF0"
                    >
                    </path>
                    <path
                      d="M61.8723 74.2C61.8723 73.0799 61.8723 72.5198 62.0903 72.092C62.282 71.7157 62.588 71.4097 62.9643 71.218C63.3922 71 63.9522 71 65.0723 71H78.6723C79.7924 71 80.3525 71 80.7803 71.218C81.1566 71.4097 81.4626 71.7157 81.6543 72.092C81.8723 72.5198 81.8723 73.0799 81.8723 74.2V81.8C81.8723 82.9201 81.8723 83.4802 81.6543 83.908C81.4626 84.2843 81.1566 84.5903 80.7803 84.782C80.3525 85 79.7924 85 78.6723 85H65.0723C63.9522 85 63.3922 85 62.9643 84.782C62.588 84.5903 62.282 84.2843 62.0903 83.908C61.8723 83.4802 61.8723 82.9201 61.8723 81.8V74.2Z"
                      fill="#CBCDD7"
                    >
                    </path>
                    <path
                      d="M75.8723 71C75.8723 70.07 75.8723 69.605 75.7701 69.2235C75.4927 68.1883 74.684 67.3796 73.6488 67.1022C73.2673 67 72.8023 67 71.8723 67C70.9423 67 70.4774 67 70.0959 67.1022C69.0606 67.3796 68.2519 68.1883 67.9745 69.2235C67.8723 69.605 67.8723 70.07 67.8723 71M65.0723 85H78.6723C79.7924 85 80.3525 85 80.7803 84.782C81.1566 84.5903 81.4626 84.2843 81.6543 83.908C81.8723 83.4802 81.8723 82.9201 81.8723 81.8V74.2C81.8723 73.0799 81.8723 72.5198 81.6543 72.092C81.4626 71.7157 81.1566 71.4097 80.7803 71.218C80.3525 71 79.7924 71 78.6723 71H65.0723C63.9522 71 63.3922 71 62.9643 71.218C62.588 71.4097 62.282 71.7157 62.0903 72.092C61.8723 72.5198 61.8723 73.0799 61.8723 74.2V81.8C61.8723 82.9201 61.8723 83.4802 62.0903 83.908C62.282 84.2843 62.588 84.5903 62.9643 84.782C63.3922 85 63.9522 85 65.0723 85Z"
                      stroke="#CBCDD7"
                      stroke-width="2.41667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                    </path>
                    <g filter="url(#filter1_d_6032_72695)">
                      <path
                        d="M10.6915 104.191H154.308C155.719 104.191 157.072 104.752 158.07 105.749C159.067 106.747 159.628 108.1 159.628 109.511V136.106C159.628 137.517 159.067 138.87 158.07 139.868C157.072 140.865 155.719 141.425 154.308 141.425H10.6915C9.28074 141.425 7.92779 140.865 6.93026 139.868C5.93272 138.87 5.37231 137.517 5.37231 136.106V109.511C5.37231 108.1 5.93272 106.747 6.93026 105.749C7.92779 104.752 9.28074 104.191 10.6915 104.191Z"
                        fill="white"
                      >
                      </path>
                    </g>
                    <path
                      d="M78.7234 113H51.0638C49.3012 113 47.8723 114.429 47.8723 116.191C47.8723 117.954 49.3012 119.383 51.0638 119.383H78.7234C80.486 119.383 81.9149 117.954 81.9149 116.191C81.9149 114.429 80.486 113 78.7234 113Z"
                      fill="#D1D5DB"
                    >
                    </path>
                    <path
                      d="M97.8723 125H51.0638C49.3012 125 47.8723 126.429 47.8723 128.191C47.8723 129.954 49.3012 131.383 51.0638 131.383H97.8723C99.6349 131.383 101.064 129.954 101.064 128.191C101.064 126.429 99.6349 125 97.8723 125Z"
                      fill="#EAECF0"
                    >
                    </path>
                    <path
                      d="M15.8723 120.2C15.8723 119.08 15.8723 118.52 16.0903 118.092C16.282 117.716 16.588 117.41 16.9643 117.218C17.3922 117 17.9522 117 19.0723 117H32.6723C33.7924 117 34.3525 117 34.7803 117.218C35.1566 117.41 35.4626 117.716 35.6543 118.092C35.8723 118.52 35.8723 119.08 35.8723 120.2V127.8C35.8723 128.92 35.8723 129.48 35.6543 129.908C35.4626 130.284 35.1566 130.59 34.7803 130.782C34.3525 131 33.7924 131 32.6723 131H19.0723C17.9522 131 17.3922 131 16.9643 130.782C16.588 130.59 16.282 130.284 16.0903 129.908C15.8723 129.48 15.8723 128.92 15.8723 127.8V120.2Z"
                      fill="#CBCDD7"
                    >
                    </path>
                    <path
                      d="M29.8723 117C29.8723 116.07 29.8723 115.605 29.7701 115.224C29.4927 114.188 28.684 113.38 27.6488 113.102C27.2673 113 26.8023 113 25.8723 113C24.9423 113 24.4774 113 24.0959 113.102C23.0606 113.38 22.2519 114.188 21.9745 115.224C21.8723 115.605 21.8723 116.07 21.8723 117M19.0723 131H32.6723C33.7924 131 34.3525 131 34.7803 130.782C35.1566 130.59 35.4626 130.284 35.6543 129.908C35.8723 129.48 35.8723 128.92 35.8723 127.8V120.2C35.8723 119.08 35.8723 118.52 35.6543 118.092C35.4626 117.716 35.1566 117.41 34.7803 117.218C34.3525 117 33.7924 117 32.6723 117H19.0723C17.9522 117 17.3922 117 16.9643 117.218C16.588 117.41 16.282 117.716 16.0903 118.092C15.8723 118.52 15.8723 119.08 15.8723 120.2V127.8C15.8723 128.92 15.8723 129.48 16.0903 129.908C16.282 130.284 16.588 130.59 16.9643 130.782C17.3922 131 17.9522 131 19.0723 131Z"
                      stroke="#CBCDD7"
                      stroke-width="2.41667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                    </path>
                    <g filter="url(#filter2_d_6032_72695)">
                      <path
                        d="M10.8191 13.1914H154.436C155.847 13.1914 157.2 13.7518 158.197 14.7493C159.195 15.7469 159.755 17.0998 159.755 18.5106V45.1063C159.755 46.517 159.195 47.87 158.197 48.8675C157.2 49.865 155.847 50.4254 154.436 50.4254H10.8191C9.40842 50.4254 8.05548 49.865 7.05794 48.8675C6.06041 47.87 5.5 46.517 5.5 45.1063V18.5106C5.5 17.0998 6.06041 15.7469 7.05794 14.7493C8.05548 13.7518 9.40842 13.1914 10.8191 13.1914Z"
                        fill="white"
                      >
                      </path>
                    </g>
                    <path
                      d="M78.8511 22H51.1915C49.4289 22 48 23.4289 48 25.1915C48 26.9541 49.4289 28.383 51.1915 28.383H78.8511C80.6137 28.383 82.0426 26.9541 82.0426 25.1915C82.0426 23.4289 80.6137 22 78.8511 22Z"
                      fill="#D1D5DB"
                    >
                    </path>
                    <path
                      d="M98 34H51.1915C49.4289 34 48 35.4289 48 37.1915C48 38.9541 49.4289 40.383 51.1915 40.383H98C99.7626 40.383 101.191 38.9541 101.191 37.1915C101.191 35.4289 99.7626 34 98 34Z"
                      fill="#EAECF0"
                    >
                    </path>
                    <path
                      d="M16 29.2C16 28.0799 16 27.5198 16.218 27.092C16.4097 26.7157 16.7157 26.4097 17.092 26.218C17.5198 26 18.0799 26 19.2 26H32.8C33.9201 26 34.4802 26 34.908 26.218C35.2843 26.4097 35.5903 26.7157 35.782 27.092C36 27.5198 36 28.0799 36 29.2V36.8C36 37.9201 36 38.4802 35.782 38.908C35.5903 39.2843 35.2843 39.5903 34.908 39.782C34.4802 40 33.9201 40 32.8 40H19.2C18.0799 40 17.5198 40 17.092 39.782C16.7157 39.5903 16.4097 39.2843 16.218 38.908C16 38.4802 16 37.9201 16 36.8V29.2Z"
                      fill="#CBCDD7"
                    >
                    </path>
                    <path
                      d="M30 26C30 25.07 30 24.605 29.8978 24.2235C29.6204 23.1883 28.8117 22.3796 27.7765 22.1022C27.395 22 26.93 22 26 22C25.07 22 24.605 22 24.2235 22.1022C23.1883 22.3796 22.3796 23.1883 22.1022 24.2235C22 24.605 22 25.07 22 26M19.2 40H32.8C33.9201 40 34.4802 40 34.908 39.782C35.2843 39.5903 35.5903 39.2843 35.782 38.908C36 38.4802 36 37.9201 36 36.8V29.2C36 28.0799 36 27.5198 35.782 27.092C35.5903 26.7157 35.2843 26.4097 34.908 26.218C34.4802 26 33.9201 26 32.8 26H19.2C18.0799 26 17.5198 26 17.092 26.218C16.7157 26.4097 16.4097 26.7157 16.218 27.092C16 27.5198 16 28.0799 16 29.2V36.8C16 37.9201 16 38.4802 16.218 38.908C16.4097 39.2843 16.7157 39.5903 17.092 39.782C17.5198 40 18.0799 40 19.2 40Z"
                      stroke="#CBCDD7"
                      stroke-width="2.41667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                    </path>
                    <defs>
                      <filter
                        id="filter0_d_6032_72695"
                        x="46.3723"
                        y="56.1914"
                        width="164.255"
                        height="47.2339"
                        filterUnits="userSpaceOnUse"
                        color-interpolation-filters="sRGB"
                      >
                        <feFlood flood-opacity="0" result="BackgroundImageFix"></feFlood>
                        <feColorMatrix
                          in="SourceAlpha"
                          type="matrix"
                          values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                          result="hardAlpha"
                        >
                        </feColorMatrix>
                        <feOffset dy="3"></feOffset>
                        <feGaussianBlur stdDeviation="2.5"></feGaussianBlur>
                        <feColorMatrix
                          type="matrix"
                          values="0 0 0 0 0.230539 0 0 0 0 0.370572 0 0 0 0 0.482993 0 0 0 0.1 0"
                        >
                        </feColorMatrix>
                        <feBlend
                          mode="normal"
                          in2="BackgroundImageFix"
                          result="effect1_dropShadow_6032_72695"
                        >
                        </feBlend>
                        <feBlend
                          mode="normal"
                          in="SourceGraphic"
                          in2="effect1_dropShadow_6032_72695"
                          result="shape"
                        >
                        </feBlend>
                      </filter>
                      <filter
                        id="filter1_d_6032_72695"
                        x="0.372314"
                        y="102.191"
                        width="164.255"
                        height="47.2339"
                        filterUnits="userSpaceOnUse"
                        color-interpolation-filters="sRGB"
                      >
                        <feFlood flood-opacity="0" result="BackgroundImageFix"></feFlood>
                        <feColorMatrix
                          in="SourceAlpha"
                          type="matrix"
                          values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                          result="hardAlpha"
                        >
                        </feColorMatrix>
                        <feOffset dy="3"></feOffset>
                        <feGaussianBlur stdDeviation="2.5"></feGaussianBlur>
                        <feColorMatrix
                          type="matrix"
                          values="0 0 0 0 0.230539 0 0 0 0 0.370572 0 0 0 0 0.482993 0 0 0 0.1 0"
                        >
                        </feColorMatrix>
                        <feBlend
                          mode="normal"
                          in2="BackgroundImageFix"
                          result="effect1_dropShadow_6032_72695"
                        >
                        </feBlend>
                        <feBlend
                          mode="normal"
                          in="SourceGraphic"
                          in2="effect1_dropShadow_6032_72695"
                          result="shape"
                        >
                        </feBlend>
                      </filter>
                      <filter
                        id="filter2_d_6032_72695"
                        x="0.5"
                        y="11.1914"
                        width="164.255"
                        height="47.2339"
                        filterUnits="userSpaceOnUse"
                        color-interpolation-filters="sRGB"
                      >
                        <feFlood flood-opacity="0" result="BackgroundImageFix"></feFlood>
                        <feColorMatrix
                          in="SourceAlpha"
                          type="matrix"
                          values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                          result="hardAlpha"
                        >
                        </feColorMatrix>
                        <feOffset dy="3"></feOffset>
                        <feGaussianBlur stdDeviation="2.5"></feGaussianBlur>
                        <feColorMatrix
                          type="matrix"
                          values="0 0 0 0 0.230539 0 0 0 0 0.370572 0 0 0 0 0.482993 0 0 0 0.1 0"
                        >
                        </feColorMatrix>
                        <feBlend
                          mode="normal"
                          in2="BackgroundImageFix"
                          result="effect1_dropShadow_6032_72695"
                        >
                        </feBlend>
                        <feBlend
                          mode="normal"
                          in="SourceGraphic"
                          in2="effect1_dropShadow_6032_72695"
                          result="shape"
                        >
                        </feBlend>
                      </filter>
                    </defs>
                  </svg>
                </div>
              </div>
            </div>

            <nav
              class="enable-bootstrap flex items-center justify-between px-3  pr-3 sm:pr-6 border-t border-border-primary-910 py-3"
              aria-label="Pagination"
            >
              <div class="btn-group btn-group-lg">
                <a class="btn btn-outline-info  disabled " href="/registries/mpsr/dashboard?before=">
                  <span class="fa fa-chevron-left"></span>
                </a>
                <a
                  class="btn btn btn-outline-info  disabled cursor-not-allowed "
                  href="/registries/mpsr/dashboard?after="
                >
                  <span class="fa fa-chevron-right"></span>
                </a>
              </div>
            </nav>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
