#pragma once

#include "Core.h"

#include "Window.h"
#include "Soul/LayerStack.h"
#include "Events/Event.h"
#include "Events/ApplicationEvent.h"
#include "Soul/ImGui/ImGuiLayer.h"

#include "Soul/Renderer/Shader.h"
#include "Soul/Renderer/Buffer.h"
#include "Soul/Renderer/VertexArray.h"

namespace Soul {

	class SOUL_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		inline static Application& Get() { return *s_Instance; }
		inline Window& GetWindow() { return *m_Window; }
	private:
		bool OnWindowClosed(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		LayerStack m_LayerStack;

		std::shared_ptr<Shader> m_Shader;
		std::shared_ptr<VertexArray> m_VertexArray;
		std::shared_ptr<VertexBuffer> m_VertexBuffer;
		std::shared_ptr<IndexBuffer> m_IndexBuffer;


		static Application* s_Instance;
	};

	//To be defined in client
	Application* CreateApplication();
}


