import React from 'react'
import Image from 'next/image';
import Link from 'next/link';

function PrivacyPolicyPage() {
  return (
    <div>

      {/* navbar starts here */}

      <nav className="bg-white border-gray-200 dark:bg-gray-900">
        <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
          <Link href="https://flowbite.com/" className="flex items-center space-x-3 rtl:space-x-reverse">
            <Image src="https://flowbite.com/docs/images/logo.svg" className="h-8" alt="Flowbite Logo" />
            <span className="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Flowbite</span>
          </Link>
          <button data-collapse-toggle="navbar-default" type="button" className="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
            <span className="sr-only">Open main menu</span>
            <svg className="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15" />
            </svg>
          </button>
          <div className="hidden w-full md:block md:w-auto" id="navbar-default">
            <ul className="font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
              <li>
                <Link href="/" className="block py-2 px-3 text-white bg-blue-700 rounded-sm md:bg-transparent md:text-blue-700 md:p-0 dark:text-white md:dark:text-blue-500" aria-current="page">Home</Link>
              </li>
              <li>
                <Link href="/" className="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">About</Link>
              </li>
              <li>
                <Link href="/" className="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Services</Link>
              </li>
              <li>
                <Link href="/" className="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Pricing</Link>
              </li>
              <li>
                <Link href="/" className="block py-2 px-3 text-gray-900 rounded-sm hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Contact</Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      {/* navbar ends here */}

      {/* privacy policy content starts here */}
      <div className="min-h-screen bg-gray-100 text-gray-800 p-6">
        <div className="max-w-3xl mx-auto bg-white shadow-md rounded-lg p-8">
          <h1 className="text-3xl font-bold mb-6 text-center">Privacy Policy</h1>
          <p className="mb-4">
            This Privacy Policy explains how we collect, use, and protect your information when you use our WhatsApp Status Saver app.
          </p>
          <ul className="list-decimal list-inside space-y-2">
            <li>We do not collect any personal information from users.</li>
            <li>The app only accesses statuses stored locally on your device.</li>
            <li>No media is uploaded to our servers.</li>
            <li>We do not track your activity or behavior.</li>
            <li>No third-party analytics are used.</li>
            <li>The app requires storage permission only to save and show statuses.</li>
            <li>We do not share your data with anyone.</li>
            <li>All saved statuses remain on your device only.</li>
            <li>We may update this policy in the future.</li>
            <li>By using the app, you agree to this privacy policy.</li>
          </ul>
          <p className="mt-6 text-sm text-gray-600">
            If you have any questions or concerns, feel free to contact us from within the app.
          </p>
        </div>
      </div>
      {/* privacy policy content ends here */}
    </div>
  )
}

export default PrivacyPolicyPage
