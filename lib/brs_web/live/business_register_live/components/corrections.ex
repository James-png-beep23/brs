defmodule BrsWeb.BusinessRegisterLive.Components.Corrections do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mt-4 space-y-6">
      <div>
        <div class="flex flex-col justify-center items-center rounded-lg mt-4 py-5 sm:py-7">
          <div class="inline-flex flex-col justify-center items-center">
            <div class="flex items-center justify-center mb-5">
              <svg
                width="151"
                height="161"
                viewBox="0 0 151 161"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M75.5 150C116.921 150 150.5 116.421 150.5 75C150.5 33.5786 116.921 0 75.5 0C34.0786 0 0.5 33.5786 0.5 75C0.5 116.421 34.0786 150 75.5 150Z"
                  fill="#E2E3E9"
                >
                </path>
                <g filter="url(#filter0_d_6032_72729)">
                  <path
                    d="M118.5 43H32.5C29.7386 43 27.5 45.2386 27.5 48V153C27.5 155.761 29.7386 158 32.5 158H118.5C121.261 158 123.5 155.761 123.5 153V48C123.5 45.2386 121.261 43 118.5 43Z"
                    fill="white"
                  >
                  </path>
                </g>
                <path
                  d="M65.5 58H39.5C37.8431 58 36.5 59.3431 36.5 61C36.5 62.6569 37.8431 64 39.5 64H65.5C67.1569 64 68.5 62.6569 68.5 61C68.5 59.3431 67.1569 58 65.5 58Z"
                  fill="#C5C8D3"
                >
                </path>
                <path
                  d="M83.5 71H39.5C37.8431 71 36.5 72.3431 36.5 74C36.5 75.6569 37.8431 77 39.5 77H83.5C85.1569 77 86.5 75.6569 86.5 74C86.5 72.3431 85.1569 71 83.5 71Z"
                  fill="#EBEBF0"
                >
                </path>
                <path
                  d="M65.5 85H39.5C37.8431 85 36.5 86.3431 36.5 88C36.5 89.6569 37.8431 91 39.5 91H65.5C67.1569 91 68.5 89.6569 68.5 88C68.5 86.3431 67.1569 85 65.5 85Z"
                  fill="#C5C8D3"
                >
                </path>
                <path
                  d="M83.5 98H39.5C37.8431 98 36.5 99.3431 36.5 101C36.5 102.657 37.8431 104 39.5 104H83.5C85.1569 104 86.5 102.657 86.5 101C86.5 99.3431 85.1569 98 83.5 98Z"
                  fill="#EBEBF0"
                >
                </path>
                <path
                  d="M65.5 112H39.5C37.8431 112 36.5 113.343 36.5 115C36.5 116.657 37.8431 118 39.5 118H65.5C67.1569 118 68.5 116.657 68.5 115C68.5 113.343 67.1569 112 65.5 112Z"
                  fill="#C5C8D3"
                >
                </path>
                <path
                  d="M83.5 125H39.5C37.8431 125 36.5 126.343 36.5 128C36.5 129.657 37.8431 131 39.5 131H83.5C85.1569 131 86.5 129.657 86.5 128C86.5 126.343 85.1569 125 83.5 125Z"
                  fill="#EBEBF0"
                >
                </path>
                <path
                  d="M137.25 112.5H122.25C114.75 112.5 111 116.25 111 123.75V148.125C111 149.156 111.844 150 112.875 150H137.25C144.75 150 148.5 146.25 148.5 138.75V123.75C148.5 116.25 144.75 112.5 137.25 112.5V112.5Z"
                  fill="#D6D9E0"
                >
                </path>
                <path
                  d="M131.456 123.45L121.725 133.181C121.35 133.556 120.994 134.288 120.918 134.812L120.393 138.525C120.206 139.875 121.144 140.813 122.494 140.625L126.206 140.1C126.731 140.025 127.462 139.669 127.837 139.294L137.569 129.563C139.237 127.894 140.044 125.944 137.569 123.469C135.094 120.975 133.144 121.763 131.456 123.45V123.45Z"
                  fill="#D6D9E0"
                  stroke="white"
                  stroke-width="2.79181"
                  stroke-miterlimit="10"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                </path>
                <path
                  d="M130.068 124.838C130.893 127.782 133.2 130.107 136.162 130.932Z"
                  fill="#D6D9E0"
                >
                </path>
                <path
                  d="M130.068 124.838C130.893 127.782 133.2 130.107 136.162 130.932"
                  stroke="white"
                  stroke-width="2.79181"
                  stroke-miterlimit="10"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                </path>
                <defs>
                  <filter
                    id="filter0_d_6032_72729"
                    x="21.5"
                    y="34"
                    width="108"
                    height="127"
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
                    <feOffset dy="-3"></feOffset>
                    <feGaussianBlur stdDeviation="3"></feGaussianBlur>
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 0.788235 0 0 0 0 0.803922 0 0 0 0 0.85098 0 0 0 0.349 0"
                    >
                    </feColorMatrix>
                    <feBlend
                      mode="normal"
                      in2="BackgroundImageFix"
                      result="effect1_dropShadow_6032_72729"
                    >
                    </feBlend>
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_6032_72729"
                      result="shape"
                    >
                    </feBlend>
                  </filter>
                </defs>
              </svg>
            </div>
            <div class="inline-flex flex-col justify-center items-center text-center">
              <h3 class="text-lg sm:text-2xl font-medium leading-none text-primary-500 mb-1">
                Corrections
              </h3>
              <p class="text-sm mt-0 text-neutral-500">
                Applications that require editing and resubmission will be listed here.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
