#pragma once

#ifdef SL_PLATFORM_WINDOWS

extern Soul::Application* Soul::CreateApplication();

int main(int argc, char** argv)
{

	Soul::Log::Init();
	SL_CORE_WARN("Initialised Core Log");
	SL_INFO("Initialised Client Log");

	auto app = Soul::CreateApplication();

	app->Run();

	delete app;
}

#endif