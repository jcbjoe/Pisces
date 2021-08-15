#pragma once

#include "Soul/Renderer/GraphicsContext.h"

struct GLFWwindow;

namespace Soul
{
	class OpenGLContext : public GraphicsContext
	{
	public:
		OpenGLContext(GLFWwindow* windowHandle);

		void Init() override;
		void SwapBuffers() override;

	private:
		GLFWwindow* m_windowHandle;
	};
}