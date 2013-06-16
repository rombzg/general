#ifndef GDL_MODEL_HPP
# define GDL_MODEL_HPP

# include <vector>
# include <string>
# include <map>
# include <GL/gl.h>
# include <GL/glu.h>

# include "Color.hpp"
# include "AnimStates.hpp"
# include "Resource.hpp"
# include "IClock.hpp"

namespace gdl
{

	////////////////////////////////////////////////////////////
	/// Forward declaration of ModelImpl.
	////////////////////////////////////////////////////////////
	class ModelImpl;

	////////////////////////////////////////////////////////////
	/// Forward declaration of AnimConfigImpl.
	////////////////////////////////////////////////////////////
	class AnimConfigImpl;

	////////////////////////////////////////////////////////////
	/// The ModelImpl class provide the gestion of your model.
	////////////////////////////////////////////////////////////
	class Model : private Resource<ModelImpl>
	{
	private:
		bool CheckUniqueAnimation();

	public:
		////////////////////////////////////////////////////////////
		/// Default constructror.
		////////////////////////////////////////////////////////////
		Model(void);

		////////////////////////////////////////////////////////////
		/// Default destructror.
		////////////////////////////////////////////////////////////
		~Model(void);

		////////////////////////////////////////////////////////////
		/// Load the model.
		///
		/// \param[in] filename Filename with the extension,
		/// relative to Game ContentRoot.
		/// \return the Model.
		////////////////////////////////////////////////////////////
		static Model	load(std::string const & filename);

		////////////////////////////////////////////////////////////
		/// Update the animation of the model.
		///
		/// \param[in] gameTime Game's clock.
		////////////////////////////////////////////////////////////
		void	update(IClock const & gameTime);

		////////////////////////////////////////////////////////////
		/// Draw the model in the Window.
		////////////////////////////////////////////////////////////
		void	draw(void);

		////////////////////////////////////////////////////////////
		/// Draw the model in the Window with immediate opengl
		/// functions. (without optimizations)
		///
		/// e.g. Needed to correctly generate your own glList
		////////////////////////////////////////////////////////////
		void	draw_immediate();

		////////////////////////////////////////////////////////////
		/// \deprecated Instead, use cut_animation with same id_start
		/// and id_end.
		///
		////////////////////////////////////////////////////////////
		void	draw_pose(int pose_id);

		////////////////////////////////////////////////////////////
		/// Print animation list to stdout.
		///
		////////////////////////////////////////////////////////////
		void	infos(void);

		////////////////////////////////////////////////////////////
		/// Play the animation.
		///
		/// \param[in] _name Animation name.
		/// \param[in] state (AnimState enum).
		/// \return If successful, true is returned.
		/// Otherwise, false is returned.
		////////////////////////////////////////////////////////////
		bool	play(std::string const & _name, char state = Anim::RUN);

		////////////////////////////////////////////////////////////
		/// Check if the animation has started.
		///
		/// \param name Animation name.
		/// \return If successful, true is returned.
		/// Otherwise, false is returned.
		////////////////////////////////////////////////////////////
		bool	animation_hasStarted(std::string const & name) const;

		////////////////////////////////////////////////////////////
		/// Check if the animation is ended.
		///
		/// \param[in] name Animation name.
		/// \return If the animation has ended, true is returned.
		/// Otherwise, false is returned.
		////////////////////////////////////////////////////////////
		bool	anim_is_ended(std::string const & name) const;

		////////////////////////////////////////////////////////////
		/// Stop the animation.
		///
		/// \param[in] name Animation name.
		////////////////////////////////////////////////////////////
		void	stop_animation(std::string const & name);

		////////////////////////////////////////////////////////////
		/// Get the animation speed.
		///
		/// \param[in] name Animation name.
		/// \return If the animation doesn't exist, -1 is returned.
		////////////////////////////////////////////////////////////
		double	get_anim_speed(std::string const & name) const;
		////////////////////////////////////////////////////////////
		/// \deprecated. Don't work, it has never actually worked.
		////////////////////////////////////////////////////////////
		double	get_anim_blendfactor(std::string const & name) const;

		////////////////////////////////////////////////////////////
		/// Get the anim state.
		///
		/// \param[in] name Animation name.
		/// \return If the animation doesn't exist, -1 is returned.
		////////////////////////////////////////////////////////////
		char	get_anim_state(std::string const & name) const;

		////////////////////////////////////////////////////////////
		/// \deprecated. Don't work, it has never actually worked.
		////////////////////////////////////////////////////////////
		void		set_anim_bendfactor(std::string const & name, double blendFactor);

		////////////////////////////////////////////////////////////
		/// Set the animation speed.
		///
		/// \param[in] name Animation name.
		/// \param[in] speed Speed of the animation.
		////////////////////////////////////////////////////////////
		void		set_anim_speed(std::string const & name, double speed);

		////////////////////////////////////////////////////////////
		/// Get the default model color.
		///
		/// \return The default color.
		////////////////////////////////////////////////////////////
		Color		get_default_model_color(void) const;

		////////////////////////////////////////////////////////////
		/// Set the default model color.
		///
		/// \param[in] color The default color.
		////////////////////////////////////////////////////////////
		void		set_default_model_color(Color const & color);

		////////////////////////////////////////////////////////////
		/// Set the anim state.
		///
		/// \param[in] name Animation name.
		/// \param[in] state (with AnimState enum).
		////////////////////////////////////////////////////////////
		void		set_anim_state(std::string const & name, char state);

		////////////////////////////////////////////////////////////
		/// Add an animation state. But it doesn't really make sens.
		///
		/// \param[in] name Animation name.
		/// \param[in] state (in Anim namespace).
		////////////////////////////////////////////////////////////
		void		add_anim_state(std::string const & name, Anim::AnimStates state);

		////////////////////////////////////////////////////////////
		/// Remove an animation state.
		///
		/// \param[in] name Animation name.
		/// \param[in] state (in Anim namespace).
		////////////////////////////////////////////////////////////
		void		remove_anim_state(std::string const & name, Anim::AnimStates state);

		////////////////////////////////////////////////////////////
		/// Fill a std::vector with animation's names.
		/// 
		/// \param[out] vector vector will be append with animation's
		/// names.
		/// \return Number of animations appended.
		////////////////////////////////////////////////////////////
		int			fill_animation_names(std::vector<std::string>& vector) const;

		////////////////////////////////////////////////////////////
		/// Copy an animation and cut it. The animation will be
		/// available for all models from the same file.
		///
		/// \param[in] _model The model.
		///
		/// \param[in] stackAnim The animation's name to copy and cut.
		///
		/// \param[in] id_start First id: start time in frames
		/// relative to the model frame rate.
		///
		/// \param[in] id_end Last id: end time in frames
		/// relative to the model frame rate.
		///
		/// \param[in] _newName Name of the new animation.
		///
		/// \return If successfull, true is returned.
		/// Otherwise, false is returned.
		////////////////////////////////////////////////////////////
		static bool	cut_animation(Model& _model,
								  std::string const & stackAnim,
								  int id_start,
								  int id_end,
								  std::string const & _newName);


		////////////////////////////////////////////////////////////
		/// \deprecated Don't really make sens, Model::draw begin it's
		/// own correct opengl context.
		////////////////////////////////////////////////////////////
		static void Begin(void);

		////////////////////////////////////////////////////////////
		/// \deprecated See Begin description.
		////////////////////////////////////////////////////////////
		static void End(void);

		using Resource<ModelImpl>::isValid;

	private:
		////////////////////////////////////////////////////////////
		/// Explicit constructor.
		///
		/// \param impl The pointer on ModelImpl.
		////////////////////////////////////////////////////////////
		explicit Model(ModelImpl* impl);

		////////////////////////////////////////////////////////////
		/// To reach private members of ModelImpl.
		////////////////////////////////////////////////////////////
		friend class ModelImpl;

		////////////////////////////////////////////////////////////
		/// To reach private members of ResourceManagerImpl.
		////////////////////////////////////////////////////////////
		friend class ResourceManagerImpl;
	};

}

#endif /* !GDL_MODEL_HPP */