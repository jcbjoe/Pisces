#pragma once

#ifdef SL_PLATFORM_WINDOWS

extern Soul::Application* Soul::CreateApplication();

int main(int argc, char** argv)
{
	auto app = Soul::CreateApplication();

	app->Run();

	delete app;
}

#endif