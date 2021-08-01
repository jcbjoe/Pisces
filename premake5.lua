workspace "Soul"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to the root folder (Solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Soul/vendor/GLFW/include"
IncludeDir["Glad"] = "Soul/vendor/Glad/include"
IncludeDir["ImGui"] = "Soul/vendor/imgui"
IncludeDir["glm"] = "Soul/vendor/glm"

include "Soul/vendor/Glad"

project "Soul"
	location "Soul"	
	kind "SharedLib"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "slpch.h"
	pchsource "Soul/src/slpch.cpp"

	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}
	
	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib",
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines {
			"SL_PLATFORM_WINDOWS",
			"SL_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}

	filter "configurations:Debug"
		defines "SL_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "SL_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "SL_DIST"
		runtime "Release"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files 
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Soul/vendor/spdlog/include",
		"Soul/src",
		"Soul/vendor",
		"%{IncludeDir.glm}"
	}

	links
	{
		"Soul"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines {
			"SL_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "SL_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "SL_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "SL_DIST"
		runtime "Release"
		optimize "On"

project "GLFW"
	location "Soul/vendor/GLFW"
    kind "StaticLib"
    language "C"
    
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
        "%{prj.location}/include/GLFW/glfw3.h",
        "%{prj.location}/include/GLFW/glfw3native.h",
        "%{prj.location}/src/glfw_config.h",
        "%{prj.location}/src/context.c",
        "%{prj.location}/src/init.c",
        "%{prj.location}/src/input.c",
        "%{prj.location}/src/monitor.c",
        "%{prj.location}/src/vulkan.c",
        "%{prj.location}/src/window.c"
    }
    
	filter "system:windows"
        buildoptions { "-std=c11", "-lgdi32" }
        systemversion "latest"
        staticruntime "On"
        
        files
        {
            "%{prj.location}/src/win32_init.c",
            "%{prj.location}/src/win32_joystick.c",
            "%{prj.location}/src/win32_monitor.c",
            "%{prj.location}/src/win32_time.c",
            "%{prj.location}/src/win32_thread.c",
            "%{prj.location}/src/win32_window.c",
            "%{prj.location}/src/wgl_context.c",
            "%{prj.location}/src/egl_context.c",
            "%{prj.location}/src/osmesa_context.c"
        }

		defines 
		{ 
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
		}
    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"

project "ImGui"
	location "Soul/vendor/imgui"
    kind "StaticLib"
    language "C++"
    
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	defines{
		"IMGUI_API=__declspec(dllexport)"
	}

	files
	{
        "%{prj.location}/imconfig.h",
        "%{prj.location}/imgui.cpp",
        "%{prj.location}/imgui.h",
		"%{prj.location}/imgui_demo.cpp",
        "%{prj.location}/imgui_draw.cpp",
        "%{prj.location}/imgui_internal.h",
		"%{prj.location}/imgui_tables.cpp",
        "%{prj.location}/imgui_widgets.cpp",
        "%{prj.location}/imstb_rectpack.h",
        "%{prj.location}/imstb_textedit.h",
        "%{prj.location}/imstb_truetype.h"
    }
    
	filter "system:windows"
        systemversion "latest"
        staticruntime "On"
		cppdialect "C++17"
        
    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"