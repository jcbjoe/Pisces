#include "Soul.h"
#include "imgui/imgui.h"

class ExampleLayer : public Soul::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		//SL_INFO("ExampleLayer::Update");

		if (Soul::Input::IsKeyPressed(SL_KEY_ENTER))
		{
			SL_TRACE("Enter key pressed!");
		}
	}

	void OnEvent(Soul::Event& event) override
	{
		//SL_TRACE("{0}", event);
	}

	//virtual void OnImGuiRender() override
	//{
	//	ImGui::Begin("Test");
	//	ImGui::Text("Hello World");
	//	ImGui::End();
	//}
};

class Sandbox : public Soul::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}

	~Sandbox()
	{

	}
};

Soul::Application* Soul::CreateApplication()
{
	return new Sandbox();
}