import { ChangeEvent, FormEvent, useState } from 'react'
import { login } from '../../redux_old/slices/authSlice'
import { useAppDispatch } from '../../redux_old/hooks'
import { useSelector } from 'react-redux'
import { RootState } from '../../redux_old/store'
import { useNavigate } from '@tanstack/react-router'
import { useTranslation } from 'react-i18next'
import { LoginRequestInterface } from '../../types/axios.types'

export const useLoginModel = () => {
  const { t } = useTranslation()
  const dispatch = useAppDispatch()
  const navigate = useNavigate()
  const auth = useSelector((state: RootState) => state.auth)

  const [loginData, setLoginData] = useState<LoginRequestInterface>(
    {} as LoginRequestInterface
  )

  const handleLoginChange = (event: ChangeEvent<HTMLInputElement>) => {
    setLoginData(
      (prevState) =>
        (prevState = { ...prevState, [event.target.name]: event.target.value })
    )
  }

  const handleLoginSubmit = (event: FormEvent) => {
    event.preventDefault()
    dispatch(login(loginData))
    navigate({ to: '/profile' })
  }

  const textData = {
    title: t('login.title'),
    emailInput: t('login.inputs.email'),
    passwordInput: t('login.inputs.password'),
    formButton: t('login.inputs.button'),
  }

  return { textData, auth, loginData, handleLoginChange, handleLoginSubmit }
}
