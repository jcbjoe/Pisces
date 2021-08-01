#pragma once

#include "Soul/Layer.h"

#include "Soul/Events/MouseEvent.h"
#include "Soul/Events/KeyEvent.h"
#include "Soul/Events/ApplicationEvent.h"

namespace Soul
{

	class SOUL_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		void OnAttach() override;
		void OnDetach() override;
		void OnUpdate() override;
		void OnEvent(Event& event) override;
	private:
		float m_Time = 0;

		bool OnMouseButtonPressedEvent(MouseButtonPressedEvent& e);
		bool OnMouseButtonReleasedEvent(MouseButtonReleasedEvent& e);
		bool OnMouseMovedEvent(MouseMovedEvent& e);
		bool OnMouseScrolledEvent(MouseScrolledEvent& e);

		bool OnKeyPressedEvent(KeyPressedEvent& e);
		bool OnKeyReleasedEvent(KeyReleasedEvent& e);
		bool OnKeyTypedEvent(KeyTypedEvent& e);

		bool OnWindowResizedEvent(WindowResizeEvent& e);

		static const char* GetClipboardText(void* user_data);

		static void SetClipboardText(void* user_data, const char* text);
	};
}



